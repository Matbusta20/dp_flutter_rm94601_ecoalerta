class Ocorrencia {
  final int? id;
  final String titulo;
  final String categoria;
  final String bairro;
  final String descricao;
  final bool urgente;

  Ocorrencia({
    this.id,
    required this.titulo,
    required this.categoria,
    required this.bairro,
    required this.descricao,
    required this.urgente,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'categoria': categoria,
      'bairro': bairro,
      'descricao': descricao,
      'urgente': urgente ? 1 : 0,
    };
  }

  factory Ocorrencia.fromMap(Map<String, dynamic> map) {
    return Ocorrencia(
      id: map['id'],
      titulo: map['titulo'],
      categoria: map['categoria'],
      bairro: map['bairro'],
      descricao: map['descricao'],
      urgente: map['urgente'] == 1,
    );
  }
}