import 'package:favorite_place/screens/map_screen.dart';
import 'package:favorite_place/utils/location_util.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// Widget reutilizável para selecionar a localização.
class LocationInput extends StatefulWidget {
  // Função callback chamada quando uma posição é selecionada.
  final Function onSelectPosition;

  // Construtor que recebe uma função de callback para quando uma posição é selecionada.
  const LocationInput({Key? key, required this.onSelectPosition}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  // Método para mostrar uma prévia do local no mapa com base na latitude e longitude fornecidas.
  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  // Método para obter a localização atual do usuário.
  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();

      // Exibe a prévia do local com base na localização atual do usuário.
      _showPreview(locData.latitude!, locData.longitude!);
      // Chama a função de callback com a posição selecionada.
      widget.onSelectPosition(LatLng(locData.latitude!, locData.longitude!));
    } catch (e) {
      return;
    }
  }

  // Método para selecionar uma posição no mapa.
  Future<void> _selectOnMap() async {
    // Navega para a tela do mapa e espera a seleção de uma posição.
    final LatLng? selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => const MapScreen(),
      ),
    );

    // Verifica se uma posição foi selecionada.
    if (selectedPosition == null) return;

    // Exibe a prévia do local com base na posição selecionada.
    _showPreview(selectedPosition.latitude, selectedPosition.longitude);
    // Chama a função de callback com a posição selecionada.
    widget.onSelectPosition(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container para exibir a prévia da imagem do local.
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
              border: Border.all(
            width: 4,
            color: Colors.white,
          )),
          child: _previewImageUrl == null
              ? const Text("Localização não informada!", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700))
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        // Linha de botões para obter a localização atual ou selecionar no mapa.
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Botão para obter a localização atual do usuário.
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on, color: Colors.white,),
              label: const Text("Localização Atual", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            ),
            // Botão para selecionar uma posição no mapa.
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map, color: Colors.white),
              label: const Text("Selecione no Mapa", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            ),
          ],
        )
      ],
    );
  }
}
