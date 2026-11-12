import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/ocorrencia_provider.dart';
import 'screens/home_screen.dart';
import 'screens/lista_ocorrencias_screen.dart';
import 'screens/form_ocorrencia_screen.dart';
import 'screens/detalhes_ocorrencia_screen.dart';
import 'screens/sobre_ods_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => OcorrenciaProvider(),
      child: const EcoAlertaApp(),
    ),
  );
}

class EcoAlertaApp extends StatelessWidget {
  const EcoAlertaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoAlerta SP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/lista': (_) => const ListaOcorrenciasScreen(),
        '/form': (_) => const FormOcorrenciaScreen(),
        '/detalhes': (_) => const DetalhesOcorrenciaScreen(),
        '/sobre': (_) => const SobreOdsScreen(),
      },
    );
  }
}