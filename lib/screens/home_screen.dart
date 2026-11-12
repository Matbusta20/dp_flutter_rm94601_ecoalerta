import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ocorrencia_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OcorrenciaProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('EcoAlerta SP • CitizenTech'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Sobre a ODS 11',
            onPressed: () => Navigator.pushNamed(context, '/sobre'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.teal.shade900,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ODS 11 • Cidades Sustentáveis',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.tealAccent),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Monitoramento cidadão de infraestrutura urbana, iluminação e zeladoria comunitária.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildIndicador(
                    'Total Registrado',
                    provider.totalOcorrencias.toString(),
                    Icons.list_alt,
                    Colors.tealAccent,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildIndicador(
                    'Casos Urgentes',
                    provider.totalUrgentes.toString(),
                    Icons.priority_high,
                    Colors.redAccent,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/lista'),
              icon: const Icon(Icons.view_list),
              label: const Text('Ver Ocorrências Cadastradas'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/form'),
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Reportar Novo Problema'),
              style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicador(String titulo, String valor, IconData icone, Color cor) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icone, size: 32, color: cor),
            const SizedBox(height: 8),
            Text(valor, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text(titulo, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}