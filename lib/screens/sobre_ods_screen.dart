import 'package:flutter/material.dart';

class SobreOdsScreen extends StatelessWidget {
  const SobreOdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Impacto Social • ODS 11')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Desafio CitizenTech FIAP',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.tealAccent),
            ),
            SizedBox(height: 12),
            Text(
              'O EcoAlerta SP conecta moradores diretamente à zeladoria urbana do município, alinhado ao Objetivo de Desenvolvimento Sustentável 11 da ONU (Tornar as cidades e os assentamentos humanos inclusivos, seguros, resilientes e sustentáveis).',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text('Desenvolvido por:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Matheus Bustamante • RM 94601'),
          ],
        ),
      ),
    );
  }
}