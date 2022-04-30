// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../dao/usuario_dao.dart';
import '../models/usuario_model.dart';
import 'generic_service.dart';

class UsuarioService implements GenericService<UsuarioModel> {
  final UsuarioDAO _usuarioDAO;

  UsuarioService(this._usuarioDAO);

  @override
  Future<bool> delete(int id) async => _usuarioDAO.delete(id);

  @override
  Future<List<UsuarioModel>> findAll() async => _usuarioDAO.findAll();

  @override
  Future<UsuarioModel?> findOne(int id) async => _usuarioDAO.findOne(id);

  @override
  Future<bool> save(value) async {
    if (value.id != null) {
      return _usuarioDAO.update(value);
    } else {
      return _usuarioDAO.create(value);
    }
  }
}