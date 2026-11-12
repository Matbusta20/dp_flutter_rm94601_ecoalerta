import 'package:flutter/material.dart';
import '../models/ocorrencia_model.dart';
import '../database/database_helper.dart';

class OcorrenciaProvider with ChangeNotifier {
  final DatabaseHelper? _dbHelper;
  List<Ocorrencia> _ocorrencias = [];
  bool _isLoading = false;
  String? _erro;

  OcorrenciaProvider({DatabaseHelper? dbHelper, bool autoLoad = true})
      : _dbHelper = dbHelper ?? DatabaseHelper.instance {
    if (autoLoad) {
      carregarOcorrencias();
    }
  }

  List<Ocorrencia> get ocorrencias => _ocorrencias;
  bool get isLoading => _isLoading;
  String? get erro => _erro;

  int get totalOcorrencias => _ocorrencias.length;
  int get totalUrgentes => _ocorrencias.where((o) => o.urgente).length;

  Future<void> carregarOcorrencias() async {
    _isLoading = true;
    _erro = null;
    notifyListeners();

    try {
      _ocorrencias = await _dbHelper!.getAll();
    } catch (e) {
      _erro = 'Erro ao carregar ocorrências: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> adicionarOcorrencia(Ocorrencia ocorrencia) async {
    await _dbHelper!.insert(ocorrencia);
    await carregarOcorrencias();
  }

  Future<void> atualizarOcorrencia(Ocorrencia ocorrencia) async {
    await _dbHelper!.update(ocorrencia);
    await carregarOcorrencias();
  }

  Future<void> removerOcorrencia(int id) async {
    await _dbHelper!.delete(id);
    await carregarOcorrencias();
  }

  void setListaParaTeste(List<Ocorrencia> lista) {
    _ocorrencias = lista;
    notifyListeners();
  }
}