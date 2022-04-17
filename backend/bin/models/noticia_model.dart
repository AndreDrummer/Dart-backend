class NoticiaModel {
  final int id;
  final String titulo;
  final String descricao;
  final String imagem;
  final DateTime dtPublicacao;
  final DateTime? dtAtualizacao;

  NoticiaModel(
    this.id,
    this.titulo,
    this.descricao,
    this.imagem,
    this.dtPublicacao,
    this.dtAtualizacao,
  );

  factory NoticiaModel.fromJson(Map<String, dynamic> json) {
    return NoticiaModel(
      json['id'] ?? '',
      json['titulo'],
      json['descricao'],
      json['imagem'],
      DateTime.fromMicrosecondsSinceEpoch(json['dtPublicacao']),
      json['dtAtualizacao'] != null
          ? DateTime.fromMicrosecondsSinceEpoch(json['dtAtualizacao'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'imagem': imagem,
    };
  }

  @override
  String toString() {
    return 'NoticiaModel(, id: $id, titulo: $titulo, descricao: $descricao, imagem: $imagem, dtPublicacao: $dtPublicacao, dtAtualizacao: $dtAtualizacao)';
  }
}
