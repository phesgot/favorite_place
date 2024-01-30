import 'package:favorite_place/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Tela de mapa para selecionar uma posição geográfica.
class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation; // Localização inicial no mapa.
  final bool isReadOnly; // Indica se o mapa é somente leitura.

  const MapScreen({
    Key? key,
    this.initialLocation = const PlaceLocation(latitude: 37.419857, longitude: -122.078827), // Localização padrão.
    this.isReadOnly = false, // Por padrão, o mapa não é somente leitura.
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition; // Posição selecionada no mapa.

  // Método chamado quando uma posição no mapa é selecionada.
  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position; // Define a posição selecionada.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecione..."), // Título da barra de aplicativo.
        actions: [
          // Botão de confirmação se uma posição foi selecionada e o mapa não é somente leitura.
          if (!widget.isReadOnly)
            IconButton(
              onPressed: _pickedPosition == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedPosition); // Retorna a posição selecionada à tela anterior.
                    },
              icon: const Icon(Icons.check), // Ícone do botão de confirmação.
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 13, // Nível de zoom inicial do mapa.
        ),
        onTap: widget.isReadOnly ? null : _selectPosition, // Permite seleção apenas se não for somente leitura.
        markers: (_pickedPosition == null && !widget.isReadOnly)
            ? {} // Não exibe marcadores se nenhuma posição foi selecionada e o mapa não é somente leitura.
            : {
                Marker(
                  markerId: const MarkerId('p1'), // Identificador do marcador.
                  position: _pickedPosition ?? widget.initialLocation.toLatLng(), // Posição do marcador.
                ),
              },
      ),
    );
  }
}
