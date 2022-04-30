import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UsuarioModel {
  DateTime? dtCreated;
  DateTime? dtUpdated;
  bool? isActive;
  String? email;
  String? password;
  String? nome;
  int? id;

  UsuarioModel();

  UsuarioModel.create(
    this.id,
    this.nome,
    this.email,
    this.isActive,
    this.dtCreated,
    this.dtUpdated,
  );

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel.create(
      map['id'] as int,
      map['nome'] as String,
      map['email'] as String,
      map['is_ativo'] == 1,
      map['dt_criacao'],
      map['dt_autalizacao'],
    );
  }

  factory UsuarioModel.fromRequest(Map<String, dynamic> map) {
    return UsuarioModel()
      ..nome = map['nome']
      ..email = map['email']
      ..password = map['password'];
  }

  @override
  String toString() {
    return 'UsuarioModel(dtCreated: $dtCreated, dtUpdated: $dtUpdated, isActive: $isActive, email: $email, nome: $nome, id: $id)';
  }

  factory UsuarioModel.fromJson(String source) =>
      UsuarioModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
