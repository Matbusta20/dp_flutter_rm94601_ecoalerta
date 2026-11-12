import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ocorrencia_model.dart';
import '../providers/ocorrencia_provider.dart';

class DetalhesOcorrenciaScreen extends StatelessWidget {
  const DetalhesOcorrenciaScreen({super.key});

  void _confirmarExclusao(BuildContext context, Ocorrencia ocorrencia) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Ocorrência'),
        content: Text('Deseja realmente remover "${ocorrencia.titulo}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          TextButton(
            onPressed: () async {
              await context.read<OcorrenciaProvider>().removerOcorrencia(ocorrencia.id!);
              if (!context.mounted) return;
              Navigator.pop(ctx);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ocorrência excluída.')),
              );
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Ocorrencia;
    final provider = context.watch<OcorrenciaProvider>();
    final ocorrencia = provider.ocorrencias.firstWhere(
          (o) => o.id == arg.id,
      orElse: () => arg,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Chip(
              label: Text(ocorrencia.urgente ? 'URGENTE' : 'PRIORIDADE NORMAL'),
              backgroundColor: ocorrencia.urgente ? Colors.redAccent : Colors.teal,
            ),
            const SizedBox(height: 12),
            Text(ocorrencia.titulo, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Categoria: ${ocorrencia.categoria}', style: const TextStyle(fontSize: 16)),
            Text('Bairro: ${ocorrencia.bairro}', style: const TextStyle(fontSize: 16)),
            const Divider(height: 32),
            const Text('Descrição:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(ocorrencia.descricao, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/form', arguments: ocorrencia),
                    icon: const Icon(Icons.edit),
                    label: const Text('Editar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _confirmarExclusao(context, ocorrencia),
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    label: const Text('Excluir', style: TextStyle(color: Colors.redAccent)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}