import 'package:flutter_test/flutter_test.dart';
import 'package:dp_flutter_rm94601_ecoalerta/models/ocorrencia_model.dart';
import 'package:dp_flutter_rm94601_ecoalerta/providers/ocorrencia_provider.dart';

void main() {
  group('Testes Unitários - Model Ocorrencia', () {
    test('01. Deve instanciar Ocorrencia corretamente', () {
      final oc = Ocorrencia(
        id: 1,
        titulo: 'Buraco na rua',
        categoria: 'Infraestrutura',
        bairro: 'Centro',
        descricao: 'Buraco grande na faixa direita',
        urgente: true,
      );
      expect(oc.titulo, 'Buraco na rua');
      expect(oc.urgente, isTrue);
    });

    test('02. toMap deve converter booleano urgente true para 1', () {
      final oc = Ocorrencia(
        titulo: 'Poste caído',
        categoria: 'Iluminação',
        bairro: 'Sé',
        descricao: 'Fios expostos na calçada',
        urgente: true,
      );
      final map = oc.toMap();
      expect(map['urgente'], 1);
      expect(map['bairro'], 'Sé');
    });

    test('03. toMap deve converter booleano urgente false para 0', () {
      final oc = Ocorrencia(
        titulo: 'Mato alto',
        categoria: 'Limpeza Urbana',
        bairro: 'Mooca',
        descricao: 'Praça precisando de poda',
        urgente: false,
      );
      expect(oc.toMap()['urgente'], 0);
    });

    test('04. fromMap deve reconstruir Ocorrencia corretamente', () {
      final map = {
        'id': 10,
        'titulo': 'Semáforo quebrado',
        'categoria': 'Mobilidade',
        'bairro': 'Pinheiros',
        'descricao': 'Cruzamento sem sinalização',
        'urgente': 1,
      };
      final oc = Ocorrencia.fromMap(map);
      expect(oc.id, 10);
      expect(oc.titulo, 'Semáforo quebrado');
      expect(oc.urgente, isTrue);
    });

    test('05. fromMap deve interpretar urgente 0 como false', () {
      final map = {
        'id': 11,
        'titulo': 'Lixeira cheia',
        'categoria': 'Limpeza Urbana',
        'bairro': 'Liberdade',
        'descricao': 'Coleta atrasada',
        'urgente': 0,
      };
      final oc = Ocorrencia.fromMap(map);
      expect(oc.urgente, isFalse);
    });
  });

  group('Testes Unitários - OcorrenciaProvider', () {
    test('06. Provider deve iniciar com lista vazia quando autoLoad é false', () {
      final provider = OcorrenciaProvider(autoLoad: false);
      expect(provider.ocorrencias, isEmpty);
      expect(provider.totalOcorrencias, 0);
    });

    test('07. totalOcorrencias deve retornar a quantidade exata de itens', () {
      final provider = OcorrenciaProvider(autoLoad: false);
      provider.setListaParaTeste([
        Ocorrencia(titulo: 'A', categoria: 'Infra', bairro: 'B', descricao: 'Desc 12345', urgente: false),
        Ocorrencia(titulo: 'B', categoria: 'Infra', bairro: 'C', descricao: 'Desc 12345', urgente: true),
      ]);
      expect(provider.totalOcorrencias, 2);
    });

    test('08. totalUrgentes deve contar apenas ocorrências marcadas como urgentes', () {
      final provider = OcorrenciaProvider(autoLoad: false);
      provider.setListaParaTeste([
        Ocorrencia(titulo: 'A', categoria: 'Infra', bairro: 'B', descricao: 'Desc 12345', urgente: false),
        Ocorrencia(titulo: 'B', categoria: 'Infra', bairro: 'C', descricao: 'Desc 12345', urgente: true),
        Ocorrencia(titulo: 'C', categoria: 'Infra', bairro: 'D', descricao: 'Desc 12345', urgente: true),
      ]);
      expect(provider.totalUrgentes, 2);
    });

    test('09. totalUrgentes deve retornar 0 quando não houver casos urgentes', () {
      final provider = OcorrenciaProvider(autoLoad: false);
      provider.setListaParaTeste([
        Ocorrencia(titulo: 'A', categoria: 'Infra', bairro: 'B', descricao: 'Desc 12345', urgente: false),
      ]);
      expect(provider.totalUrgentes, 0);
    });

    test('10. Provider deve notificar ouvintes ao atualizar lista', () {
      final provider = OcorrenciaProvider(autoLoad: false);
      bool notificado = false;
      provider.addListener(() => notificado = true);

      provider.setListaParaTeste([
        Ocorrencia(titulo: 'Teste', categoria: 'Infra', bairro: 'B', descricao: 'Desc 12345', urgente: true),
      ]);
      expect(notificado, isTrue);
    });
  });
}