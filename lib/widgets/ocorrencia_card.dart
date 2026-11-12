import 'package:flutter/material.dart';
import '../models/ocorrencia_model.dart';

class OcorrenciaCard extends StatelessWidget {
  final Ocorrencia ocorrencia;
  final VoidCallback onTap;

  const OcorrenciaCard({
    super.key,
    required this.ocorrencia,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: ocorrencia.urgente ? Colors.redAccent : Colors.teal,
          child: Icon(
            ocorrencia.urgente ? Icons.warning_amber_rounded : Icons.location_city,
            color: Colors.white,
          ),
        ),
        title: Text(
          ocorrencia.titulo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${ocorrencia.categoria} • Bairro: ${ocorrencia.bairro}'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}