import 'package:favorite_place/screens/map_screen.dart';
import 'package:favorite_place/widgets/coordenadas.dart';
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      place.location!.address!, // Exibe o endereço do lugar.
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Coordenadas(latitude: place.location?.latitude, longitude: place.location?.longitude),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              // Navega para a tela do mapa para visualizar a localização do lugar.
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                      isReadOnly: true,
                      initialLocation: place.location! // Passa a localização inicial para a tela do mapa.
                      ),
                ),
              );
            },
            icon: const Icon(Icons.map, size: 30,), // Ícone do botão para visualizar no mapa.
            label: const Text("Ver no mapa", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
            style: ButtonStyle(
              elevation: const MaterialStatePropertyAll(0), // Define a elevação do botão.
              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Define o tamanho do alvo do toque.
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))), // Define a forma do botão.
            ),
          ),
        ],
      ),
    );
  }
}
