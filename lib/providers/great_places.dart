import 'dart:io';
import 'dart:math';
import 'package:favorite_place/utils/location_util.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';
import '../utils/db_util.dart';

// Classe GreatPlaces fornece funcionalidades para gerenciar lugares favoritos.
class GreatPlaces with ChangeNotifier {
  List<Place> _items = []; // Lista de lugares favoritos.

  // Carrega os lugares favoritos do banco de dados.
  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places'); // Obtém dados do banco de dados.
    _items = dataList
        .map(
          (item) => Place(
        id: item['id'], // ID do lugar.
        title: item['title'], // Título do lugar.
        image: File(item['image']), // Imagem do lugar.
        location: PlaceLocation(
          latitude: item['latitude'], // Latitude do lugar.
          longitude: item['longitude'], // Longitude do lugar.
          address: item['address'], // Endereço do lugar.
        ),
      ),
    )
        .toList(); // Mapeia os dados para criar instâncias de Place.
    notifyListeners(); // Notifica os ouvintes sobre as alterações.
  }

  // Retorna uma cópia da lista de lugares favoritos.
  List<Place> get items {
    return [..._items];
  }

  // Retorna o número de lugares favoritos.
  int get itemsCount {
    return _items.length;
  }

  // Retorna o lugar na posição do índice especificado.
  Place itemByIndex(int index) {
    return _items[index];
  }

  // Adiciona um novo lugar favorito.
  Future<void> addPlace(String title, File image, LatLng position) async {
    String address = await LocationUtil.getAddressFrom(position); // Obtém o endereço a partir da posição.

    // Cria um novo lugar com um ID aleatório.
    final newPlace = Place(
      id: Random().nextDouble().toString(), // ID aleatório.
      title: title, // Título do lugar.
      image: image, // Imagem do lugar.
      location: PlaceLocation(
        latitude: position.latitude, // Latitude do lugar.
        longitude: position.longitude, // Longitude do lugar.
        address: address, // Endereço do lugar.
      ),
    );

    _items.add(newPlace); // Adiciona o novo lugar à lista.

    // Insere os dados do novo lugar no banco de dados.
    DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'address': address,
    });

    notifyListeners(); // Notifica os ouvintes sobre as alterações na lista de lugares.
  }
}
