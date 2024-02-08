// Importações necessárias para o aplicativo.
import 'package:favorite_place/providers/great_places.dart';
import 'package:favorite_place/screens/place_list_screen.dart';
import 'package:favorite_place/screens/place_detail_screen.dart';
import 'package:favorite_place/screens/place_form_screen.dart';
import 'package:favorite_place/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Função principal que inicia a execução do aplicativo.
void main() {
  // Inicia o aplicativo chamando o construtor MyApp.
  runApp(const MyApp());
}

// Classe que representa o aplicativo em si.
class MyApp extends StatelessWidget {
  // Construtor da classe MyApp.
  const MyApp({super.key});

  // Método de construção do widget principal do aplicativo.
  @override
  Widget build(BuildContext context) {
    // Retorna um provedor de mudanças (ChangeNotifierProvider).
    // O provedor fornece o estado gerenciado pela classe GreatPlaces para os widgets abaixo dele na árvore.
    return ChangeNotifierProvider(
      // Cria uma instância de GreatPlaces para fornecer ao aplicativo.
      create: (context) => GreatPlaces(),
      // MaterialApp é o widget principal do aplicativo.
      child: MaterialApp(
        // Define o tema do aplicativo.
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          // Define o tema do app bar.
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.purple,
            iconTheme: IconThemeData(color: Colors.white, size: 30),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
          ),
          // Define o tema dos botões de texto.
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              iconColor: const MaterialStatePropertyAll(Colors.white),
              textStyle: const MaterialStatePropertyAll(TextStyle(color: Colors.white)),
              overlayColor: MaterialStatePropertyAll(Colors.grey.shade300),
            ),
          ),
          // Define o tema dos botões elevados (botões de destaque).
          elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.purple),
              iconColor: MaterialStatePropertyAll(Colors.white),
            ),
          ),
        ),
        // Desativa a faixa de depuração no canto superior direito do aplicativo.
        debugShowCheckedModeBanner: false,
        // Define o título do aplicativo.
        title: 'Favorite Place',
        // Define a tela inicial do aplicativo.
        home: const PlaceListScreen(),
        // Define as rotas do aplicativo.
        routes: {
          // Define a rota para a tela de formulário de lugar.
          AppRoutes.PLACE_FORM: (context) => const PlaceFormScreen(),
          // Define a rota para a tela de detalhes do lugar.
          AppRoutes.PLACE_DETAIL: (context) => const PlaceDetailScreen(),
        },
      ),
    );
  }
}
