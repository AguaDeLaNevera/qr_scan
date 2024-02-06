import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/providers/ui_provider.dart';
import 'package:qr_scan/screens/screens.dart';
import 'package:qr_scan/widgets/widgets.dart';

// Pantalla principal de l'aplicació
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              // Esborra tots els escanejos quan es fa clic a l'ícona de paperera
              Provider.of<ScanListProvider>(context, listen: false).esborraTots();
            },
          )
        ],
      ),
      body: _HomeScreenBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// Cos de la pantalla principal
class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    
    // Obtenim l'índex actual per canviar entre les pantalles
    final currentIndex = uiProvider.selectedMenuOpt;
    
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    // Segons l'índex actual, mostrem la pantalla corresponent
    switch (currentIndex) {
      case 0:
        // Carreguem els escanejos de tipus 'geo' i mostrem la pantalla de mapes
        scanListProvider.carregaScansPerTipus('geo');
        return MapasScreen();

      case 1:
        // Carreguem els escanejos de tipus 'http' i mostrem la pantalla de direccions
        scanListProvider.carregaScansPerTipus('http');
        return DireccionsScreen();

      default:
        // Per defecte, carreguem els escanejos de tipus 'geo' i mostrem la pantalla de mapes
        scanListProvider.carregaScansPerTipus('geo');
        return MapasScreen();
    }
  }
}
