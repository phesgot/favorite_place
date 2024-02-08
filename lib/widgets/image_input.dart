import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

// Widget reutilizável para capturar e exibir uma imagem.
class ImageInput extends StatefulWidget {
  // Função callback chamada quando uma imagem é selecionada.
  final Function onSelectImage;

  // Construtor que recebe uma função de callback para quando uma imagem é selecionada.
  const ImageInput({Key? key, required this.onSelectImage}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  // Variável para armazenar a imagem capturada.
  File? _storedImage;

  // Método para tirar uma foto usando a câmera do dispositivo.
  _takePicture() async {
    final ImagePicker picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(
      source: ImageSource.camera, // Usa a câmera como fonte.
      maxWidth: 600, // Define a largura máxima da imagem.
    );

    if (imageFile == null) return; // Verifica se a imagem é nula.

    // Atualiza o estado para exibir a imagem capturada.
    setState(() {
      _storedImage = File(imageFile.path);
    });

    // Obtém o diretório de aplicativos onde a imagem será armazenada.
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage!.path); // Obtém o nome do arquivo.
    // Copia a imagem para o diretório de aplicativos.
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
    // Chama a função de callback com a imagem salva.
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Container para exibir a imagem capturada ou uma mensagem se nenhuma imagem foi capturada.
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: Colors.white),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
            _storedImage!, // Exibe a imagem capturada.
            width: double.infinity,
            fit: BoxFit.cover,
          )
              : const Text("Nenhuma Imagem!", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),), // Mensagem exibida se nenhuma imagem foi capturada.
        ),
        // Botão para tirar uma foto.
        Expanded(
          child: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextButton.icon(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  backgroundColor: const MaterialStatePropertyAll(Colors.purple),
                ),
                onPressed: _takePicture, // Chama o método para tirar uma foto.
                icon: const Icon(Icons.camera_alt, size: 50, color: Colors.white), // Ícone da câmera.
                label: const Text("Tirar Foto", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)
                ), // Texto do botão.
              ),
            ),
          ),
        ),
      ],
    );
  }
}
