import 'package:flutter/material.dart';

// Classe que proporciona funcionalitats per gestionar l'estat de la interfície d'usuari
class UIProvider extends ChangeNotifier {
  int _selectedMenuOpt = 1; // Opció de menú seleccionada per defecte

  // Getter per obtenir l'opció de menú seleccionada
  int get selectedMenuOpt {
    return this._selectedMenuOpt;
  }

  // Setter per assignar i notificar canvis a l'opció de menú seleccionada
  set selectedMenuOpt(int index) {
    this._selectedMenuOpt = index;
    notifyListeners(); // Notifiquem als observadors del canvi
  }
}
