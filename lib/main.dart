import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/db_provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/providers/ui_provider.dart';
import 'package:qr_scan/screens/home_screen.dart';
import 'package:qr_scan/screens/mapa_screen.dart';

void main() => runApp(MultiProvider(
  // MultiProvider permet proporcionar diversos tipus de proveïdors
  providers: [
    // Proveïdor per al control d'estat de la interfície d'usuari (UI)
    ChangeNotifierProvider(create: (_) => UIProvider()),
    // Proveïdor per al control d'estat de la llista d'escanejos
    ChangeNotifierProvider(create: (_) => ScanListProvider()),
  ],
  // L'aplicació principal
  child: MyApp(),
));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      initialRoute: 'home', // Ruta inicial de l'aplicació
      routes: {
        'home': (_) => HomeScreen(), // Ruta per a la pantalla principal
        'mapa': (_) => MapaScreen(), // Ruta per a la pantalla de mapa
      },
      theme: ThemeData(
        // Configuració del tema de l'aplicació
        colorScheme: ColorScheme.light().copyWith(
          primary: Colors.deepPurple, // Canviem el color principal a lila profund
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple, // Canviem el color del botó de flotació a lila profund
        ),
      ),
    );
  }
}
