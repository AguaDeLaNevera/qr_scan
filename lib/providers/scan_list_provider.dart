import 'package:flutter/material.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';

// Classe que proporciona funcionalitats per gestionar la llista d'escanejos
class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = []; // Llista d'escanejos
  String tipusSeleccionat = 'http'; // Tipus d'escaneig seleccionat per defecte

  // Mètode per afegir un nou escaneig
  Future<ScanModel> nouScan(String valor) async {
    final nouScan =
        ScanModel(valor: valor); // Creem una nova instància de ScanModel
    final id = await DBProvider.db
        .insertScan(nouScan); // Inserim l'escaneig a la base de dades
    nouScan.id = id; // Assignem l'ID generat a la instància de ScanModel

    // Afegim l'escaneig a la llista si el tipus coincideix amb el tipus seleccionat
    if (nouScan.tipus == tipusSeleccionat) {
      this.scans.add(nouScan);
      notifyListeners(); // Notifiquem als observadors del canvi
    }

    return nouScan; // Retornem l'escaneig creat
  }

  // Mètode per carregar tots els escanejos de la base de dades
  carregaScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  // Mètode per carregar els escanejos d'un tipus específic
  carregaScansPerTipus(String tipus) async {
    final scans = await DBProvider.db.getScanByTipus(tipus);
    this.scans = [...scans];
    notifyListeners();
  }

  // Mètode per esborrar tots els escanejos
  esborraTots() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  // Mètode per esborrar un escaneig per ID
  esborraPerId(int id) async {
    await DBProvider.db.deleteScanById(id);
    this.scans.removeWhere((scan) => scan.id == id);
    notifyListeners();
  }
}
