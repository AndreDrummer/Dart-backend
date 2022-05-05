// ignore_for_file: public_member_api_docs, sort_constructors_first
class NoticiaModel {
  int? id;
  String? title;
  String? description;
  DateTime? dtCreated;
  DateTime? dtUpdated;
  int? userId;

  NoticiaModel();

  factory NoticiaModel.fromMap(Map<String, dynamic> map) {
    return NoticiaModel()
      ..id = map['id']
      ..title = map['titulo']
      ..description = map['descricao'].toString()
      ..dtCreated = map['dt_criacao']
      ..dtUpdated = map['dt_autalizacao']
      ..userId = map['id_usuario'];
  }

  factory NoticiaModel.fromRequest(Map<String, dynamic> map) {
    return NoticiaModel()
      ..id = map['id']
      ..title = map['title']
      ..description = map['description']
      ..userId = map['userid'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'NoticiaModel(id: $id, title: $title, description: $description, dtCreated: $dtCreated, dtUpdated: $dtUpdated, userId: $userId)';
  }
}
