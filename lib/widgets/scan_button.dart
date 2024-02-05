import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/screens/home_screen.dart';
import 'package:qr_scan/utils/utils.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// Widget per mostrar el botó d'escaneig
class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () async {
        print('Botó polsat!');

        // Utilitzem FlutterBarcodeScanner per escanejar un codi de barres o QR
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancel', false, ScanMode.QR);

        if (barcodeScanRes != '-1') {
          // Obtenim el proveïdor de la llista d'escanejos mitjançant Provider
          final scanListProvider =
              Provider.of<ScanListProvider>(context, listen: false);
          // Creem un nou escaneig basat en el resultat de l'escaneig
          ScanModel nouScan = ScanModel(valor: barcodeScanRes);
          scanListProvider.nouScan(barcodeScanRes);
          launchURL(context, nouScan);
        } else {
          // Torna a la pàgina inicial
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      },
    );
  }
}
