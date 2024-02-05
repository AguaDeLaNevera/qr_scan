import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Classe que proporciona funcionalitats relacionades amb la base de dades
class DBProvider {
  
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  // Obté la instància de la base de dades
  Future<Database> get database async {
    if (_database == null) _database = await initDB();

    return _database!;
  }

  // Inicialitza la base de dades
  Future<Database> initDB() async {
    // Obtenim el directori de documents de l'aplicació
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Scans.db');

    // Creació de la base de dades
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipus TEXT,
            valor TEXT
          )
        ''');
      },
    );
  }

  // Mètode per inserir un nou escaneig amb una consulta SQL directa
  Future<int> insertRawScan(ScanModel nouScan) async {
    final id = nouScan.id;
    final tipus = nouScan.tipus;
    final valor = nouScan.valor;

    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipus, valor)
      VALUES ($id, $tipus, $valor)
    ''');
    return res;
  }

  // Mètode per inserir un nou escaneig amb una consulta simplificada
  Future<int> insertScan(ScanModel nouScan) async {
    final db = await database;
    
    final res = await db.insert('Scans', nouScan.toMap());
    return res;
  }

  // Obté tots els escaneigs de la base de dades
  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');
    return res.isNotEmpty ? res.map((e) => ScanModel.fromMap(e)).toList() : [];
  }

  // Obté un escaneig per ID
  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    if (res.isNotEmpty) {
      return ScanModel.fromMap(res.first);
    }
    return null;
  }

  // Obté tots els escaneigs per tipus
  Future<List<ScanModel>> getScanByTipus(String tipus) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipus = ?', whereArgs: [tipus]);
    return res.isNotEmpty ? res.map((e) => ScanModel.fromMap(e)).toList() : [];
  }

  // Actualitza un escaneig existent
  Future<int> updateScan(ScanModel nouScan) async {
    final db = await database;
    final res = db.update('Scans', nouScan.toMap(), where: 'id = ?', whereArgs: [nouScan.id]);
    
    return res;
  }

  // Elimina un escaneig per ID
  Future<int> deleteScanById(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  // Elimina tots els escaneigs de la base de dades
  Future<int> deleteAllScans() async {
    final db = await database;
    final res = db.rawDelete('''
      DELETE FROM Scans
    ''');
    return res;
  }
}
