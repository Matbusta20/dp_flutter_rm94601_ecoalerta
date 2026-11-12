import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ocorrencia_provider.dart';
import '../widgets/ocorrencia_card.dart';

class ListaOcorrenciasScreen extends StatelessWidget {
  const ListaOcorrenciasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ocorrências Urbanas')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/form'),
        child: const Icon(Icons.add),
      ),
      body: Consumer<OcorrenciaProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.erro != null) {
            return Center(child: Text(provider.erro!));
          }
          if (provider.ocorrencias.isEmpty) {
            return const Center(
              child: Text(
                'Nenhuma ocorrência registrada ainda.\nToque no "+" para reportar um problema!',
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            itemCount: provider.ocorrencias.length,
            itemBuilder: (context, index) {
              final item = provider.ocorrencias[index];
              return OcorrenciaCard(
                ocorrencia: item,
                onTap: () => Navigator.pushNamed(
                  context,
                  '/detalhes',
                  arguments: item,
                ),
              );
            },
          );
        },
      ),
    );
  }
}