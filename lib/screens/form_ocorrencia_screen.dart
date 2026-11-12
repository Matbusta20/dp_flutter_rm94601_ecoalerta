import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ocorrencia_model.dart';
import '../providers/ocorrencia_provider.dart';

class FormOcorrenciaScreen extends StatefulWidget {
  const FormOcorrenciaScreen({super.key});

  @override
  State<FormOcorrenciaScreen> createState() => _FormOcorrenciaScreenState();
}

class _FormOcorrenciaScreenState extends State<FormOcorrenciaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _bairroController = TextEditingController();
  final _descricaoController = TextEditingController();

  String _categoriaSelecionada = 'Infraestrutura';
  bool _urgente = false;
  Ocorrencia? _ocorrenciaEdicao;
  bool _isInit = true;

  final List<String> _categorias = [
    'Infraestrutura',
    'Iluminação',
    'Limpeza Urbana',
    'Mobilidade',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Ocorrencia) {
        _ocorrenciaEdicao = args;
        _tituloController.text = args.titulo;
        _bairroController.text = args.bairro;
        _descricaoController.text = args.descricao;
        _categoriaSelecionada = args.categoria;
        _urgente = args.urgente;
      }
      _isInit = false;
    }
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    final novaOcorrencia = Ocorrencia(
      id: _ocorrenciaEdicao?.id,
      titulo: _tituloController.text.trim(),
      categoria: _categoriaSelecionada,
      bairro: _bairroController.text.trim(),
      descricao: _descricaoController.text.trim(),
      urgente: _urgente,
    );

    final provider = context.read<OcorrenciaProvider>();
    if (_ocorrenciaEdicao == null) {
      await provider.adicionarOcorrencia(novaOcorrencia);
    } else {
      await provider.atualizarOcorrencia(novaOcorrencia);
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _ocorrenciaEdicao == null
              ? 'Ocorrência registrada com sucesso!'
              : 'Ocorrência atualizada com sucesso!',
        ),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final editando = _ocorrenciaEdicao != null;

    return Scaffold(
      appBar: AppBar(title: Text(editando ? 'Editar Ocorrência' : 'Nova Ocorrência')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: 'Título do Problema *', border: OutlineInputBorder()),
                validator: (v) => (v == null || v.trim().length < 4) ? 'Informe um título válido (mín. 4 letras)' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _categoriaSelecionada,
                decoration: const InputDecoration(labelText: 'Categoria', border: OutlineInputBorder()),
                items: _categorias.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (val) => setState(() => _categoriaSelecionada = val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bairroController,
                decoration: const InputDecoration(labelText: 'Bairro / Localização *', border: OutlineInputBorder()),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Informe o bairro' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Descrição Detalhada *', border: OutlineInputBorder()),
                validator: (v) => (v == null || v.trim().length < 10) ? 'Descreva o problema (mín. 10 caracteres)' : null,
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: const Text('Marcar como Urgente (Risco imediato)'),
                value: _urgente,
                onChanged: (val) => setState(() => _urgente = val),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _salvar,
                  icon: const Icon(Icons.save),
                  label: Text(editando ? 'Salvar Alterações' : 'Cadastrar Ocorrência'),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}