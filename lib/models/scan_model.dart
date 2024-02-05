import 'dart:convert';

// Importem la classe LatLng de la biblioteca google_maps_flutter.dart
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

// Definim la classe ScanModel
class ScanModel{
  // Atributs de la classe
  int? id;
  String? tipus;
  String valor;

  // Constructor de la classe
  ScanModel({
    this.id,
    this.tipus,
    required this.valor,
  }){
    // Comprovem si el valor conté 'http' per determinar el tipus
    if(this.valor.contains('http')){
      this.tipus = 'http';
    }
    else{
      this.tipus = 'geo';
    }
  }

  // Mètode per obtenir les coordenades LatLng
  LatLng getLatLng(){
    // Extreiem les coordenades de la cadena de text 'geo' i les separem
    final latLng = this.valor.substring(4).split(',');
    final latitude = double.parse(latLng[0]);
    final longitude = double.parse(latLng[1]);
    return LatLng(latitude, longitude);
  }

  // Factoria per crear una instància de ScanModel des de JSON
  factory ScanModel.fromJson(String str) => ScanModel.fromMap(json.decode(str));

  // Mètode per convertir l'objecte a JSON
  String toJson() => json.encode(toMap());

  // Factoria per crear una instància de ScanModel des de Map
  factory ScanModel.fromMap(Map<String, dynamic> json) => ScanModel(
    id: json["id"],
    tipus: json["tipus"],
    valor: json["valor"],
  );

  // Mètode per convertir l'objecte a Map
  Map<String, dynamic> toMap() => {
    "id": id,
    "tipus": tipus, 
    "valor": valor,
  };
}
