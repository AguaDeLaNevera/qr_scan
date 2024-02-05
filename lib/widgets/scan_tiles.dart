import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/utils/utils.dart';

// Widget per mostrar la llista d'escanejos en forma de "tiles"
class ScanTiles extends StatelessWidget {
  final String tipus;

  const ScanTiles({Key? key, required this.tipus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtenim el proveïdor de la llista d'escanejos mitjançant Provider
    final scanListProvider = Provider.of<ScanListProvider>(context);

    // Obtenim la llista d'escanejos
    final scans = scanListProvider.scans;

    // Retorna una llista de tiles amb opcions de Dismissible per esborrar escanejos
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, index) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
          child: Align(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.delete_forever),
            ),
            alignment: Alignment.centerRight,
          ),
        ),
        onDismissed: (DismissDirection direccio) {
          // Esborra l'escaneig pel seu ID quan és eliminat mitjançant Dismissible
          Provider.of<ScanListProvider>(context, listen: false)
              .esborraPerId(scans[index].id!);
        },
        child: ListTile(
          // Icona a l'esquerra basada en el tipus d'escaneig
          leading: Icon(
            this.tipus == 'http' ? Icons.home_outlined : Icons.map_outlined,
          ),
          title: Text(scans[index].valor), // Valor de l'escaneig
          subtitle: Text(
              scans[index].id.toString()), // ID de l'escaneig com a subtítol
          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.grey), // Icona de la dreta
          onTap: () {
            // Obrir l'URL quan es fa clic en un escaneig
            launchURL(context, scans[index]);
          },
        ),
      ),
    );
  }
}
