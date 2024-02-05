import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scan/models/scan_model.dart';

// Pantalla que mostra un mapa amb una ubicació específica basada en les dades d'escaneig
class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    // Obtenim les dades d'escaneig passades com a arguments de la ruta de la pantalla
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    // Definim la posició inicial de la càmera basada en les coordenades de l'escaneig
    final CameraPosition _puntInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 50,
    );

    // Creem un conjunt de marcadors amb una única marca basada en les coordenades de l'escaneig
    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
      markerId: MarkerId('id1'),
      position: scan.getLatLng(),
    ));

    // Retorna la pantalla amb un mapa de Google amb la posició inicial i el marcador
    return Scaffold(
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        markers: markers,
        mapType: MapType.hybrid,
        initialCameraPosition: _puntInicial,
        onMapCreated: (GoogleMapController controller) {
          // Assigna el controlador del mapa al completar la inicialització
          _controller.complete(controller);
        },
      ),
    );
  }
}
