import 'package:favorite_place/screens/map_screen.dart';
import 'package:flutter/material.dart';

import '../models/place.dart';

// Tela de detalhes do lugar.
class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    // Obtém o lugar passado como argumento para esta tela.
    Place place = ModalRoute.of(context)!.settings.arguments as Place;

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title), // Título da barra de aplicativo exibindo o título do lugar.
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image, // Exibe a imagem do lugar.
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            place.location!.address!, // Exibe o endereço do lugar.
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              // Navega para a tela do mapa para visualizar a localização do lugar.
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    isReadOnly: true,
                    initialLocation: place.location!, // Passa a localização inicial para a tela do mapa.
                  ),
                ),
              );
            },
            icon: const Icon(Icons.map), // Ícone do botão para visualizar no mapa.
            label: const Text(
              "Ver no mapa",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}