import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

// Chave de API do Google Maps.
const googleApiKey = 'AIzaSyCnXUwfydia2qTaXMDGAxFDHWisjRrNyL4';

// Classe utilitária para operações relacionadas à localização.
class LocationUtil {
  // Método estático para gerar uma imagem de pré-visualização de localização com base nas coordenadas geográficas fornecidas.
  static String generateLocationPreviewImage({
    double? latitude,
    double? longitude,
  }) {
    // URL para gerar a imagem de pré-visualização do Google Static Maps.
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap'
        '&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey';
  }

  // Método estático para obter o endereço a partir das coordenadas geográficas fornecidas.
  static Future<String> getAddressFrom(LatLng position) async {
    // Constrói a URL para a requisição HTTP de geocodificação reversa.
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleApiKey');

    // Faz uma requisição HTTP para obter o endereço correspondente às coordenadas.
    final response = await http.get(url);

    // Decodifica a resposta JSON e obtém o endereço formatado a partir dela.
    return json.decode(response.body)['results'][0]['formatted_address'].toString();
  }
}
