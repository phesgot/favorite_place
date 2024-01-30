import 'dart:io'; // Importa a biblioteca para operações de arquivo.

import 'package:google_maps_flutter/google_maps_flutter.dart'; // Importa a biblioteca do Google Maps.

// Classe que representa a localização de um lugar.
class PlaceLocation {
  final double latitude; // Latitude da localização.
  final double longitude; // Longitude da localização.
  final String? address; // Endereço da localização, pode ser nulo.

  // Construtor da classe PlaceLocation.
  const PlaceLocation({
    required this.latitude, // Latitude é obrigatória.
    required this.longitude, // Longitude é obrigatória.
    this.address, // Endereço é opcional.
  });

  // Método para converter a localização em um objeto LatLng do Google Maps.
  LatLng toLatLng() {
    return LatLng(latitude, longitude); // Retorna um objeto LatLng com a latitude e longitude.
  }
}

// Classe que representa um lugar.
class Place {
  final String id; // Identificador do lugar.
  final String title; // Título do lugar.
  final PlaceLocation? location; // Localização do lugar.
  final File image; // Imagem do lugar.

  // Construtor da classe Place.
  Place({
    required this.id, // ID é obrigatório.
    required this.title, // Título é obrigatório.
    required this.location, // Localização é obrigatória.
    required this.image, // Imagem é obrigatória.
  });
}
