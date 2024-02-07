import 'dart:io';

import 'package:favorite_place/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../widgets/coordenadas.dart';
import '../widgets/image_input.dart';

// Tela para adicionar um novo lugar.
class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({Key? key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController(); // Controlador para o campo de texto do título.
  File? _pickedImage; // Imagem selecionada.
  LatLng? _pickedPosition; // Posição selecionada no mapa.
  String _latitude = "";
  String _longitude = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Novo Lugar")), // Barra de aplicativo com o título "Novo Lugar".
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController, // Controlador para o campo de texto do título.
                      decoration: const InputDecoration(
                        labelText: "Titulo",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            width: 2, // Espessura da borda
                          ),
                        ),
                      ), // Rótulo do campo de texto.
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 10),
                    ImageInput(onSelectImage: _selectImage), // Widget para selecionar uma imagem.
                    const SizedBox(height: 10),
                    LocationInput(
                      onSelectPosition: _selectPosition, // Widget para selecionar a posição no mapa.
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.blue.shade100 ,border: Border.all(width: 1, color: Colors.indigo)),
                      child: Coordenadas(latitude: _pickedPosition?.latitude, longitude: _pickedPosition?.longitude,)
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _isValidForm() ? _submitForm : null, // Função chamada ao pressionar o botão de adicionar.
            icon: const Icon(Icons.add), // Ícone do botão.
            label: const Text("Adicionar", style: TextStyle(color: Colors.black)), // Texto do botão.
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

  // Método para selecionar a imagem.
  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage; // Define a imagem selecionada.
    });
  }

  // Método para selecionar a posição no mapa.
  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position; // Define a posição selecionada.
    });
  }

  // Método para verificar se o formulário é válido.
  bool _isValidForm() {
    return _titleController.text.isNotEmpty && _pickedImage != null && _pickedPosition != null;
  }

  // Método para enviar o formulário.
  void _submitForm() {
    if (!_isValidForm()) return; // Verifica se o formulário é válido.

    // Adiciona o lugar utilizando o provedor de GreatPlaces.
    Provider.of<GreatPlaces>(context, listen: false).addPlace(_titleController.text, _pickedImage!, _pickedPosition!);

    Navigator.of(context).pop(); // Fecha a tela de formulário.
  }
}
