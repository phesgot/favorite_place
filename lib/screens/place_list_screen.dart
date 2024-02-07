import 'package:favorite_place/providers/great_places.dart';
import 'package:favorite_place/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Tela que exibe a lista de lugares favoritos.
class PlaceListScreen extends StatelessWidget {
  // Construtor da tela de lista de lugares.
  const PlaceListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lugares Salvos"), // Título da barra de aplicativos.
        actions: [
          // Ícone de adição para adicionar novos lugares.
          IconButton(
            onPressed: () {
              // Navega para a tela de formulário de lugar quando o ícone é pressionado.
              Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        // Constrói o conteúdo da tela com base no estado futuro de carregamento de lugares.
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator()) // Exibe um indicador de progresso se estiver carregando.
            : Consumer<GreatPlaces>(
                // Recria a tela sempre que GreatPlaces mudar.
                child: const Center(
                  child: Text('Nenhum local cadastrado!'), // Mensagem exibida se nenhum local estiver cadastrado.
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.itemsCount == 0
                    ? ch! // Exibe a mensagem se não houver lugares cadastrados.
                    : ListView.builder(
                        // Constrói uma lista de lugares se houver lugares cadastrados.
                        itemCount: greatPlaces.itemsCount,
                        itemBuilder: (ctx, i) => ListTile(
                          // Exibe detalhes de cada lugar em um ListTile.
                          leading: CircleAvatar(
                            // Exibe a imagem do lugar como avatar.
                            backgroundImage: FileImage(
                              greatPlaces.itemByIndex(i).image,
                            ),
                          ),
                          title: Text(greatPlaces.itemByIndex(i).title), // Título do lugar.
                          subtitle: Text(greatPlaces.itemByIndex(i).location!.address!), // Endereço do lugar.
                          onTap: () {
                            // Navega para a tela de detalhes do lugar quando o ListTile é pressionado.
                            Navigator.of(context)
                                .pushNamed(AppRoutes.PLACE_DETAIL, arguments: greatPlaces.itemByIndex(i));
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
