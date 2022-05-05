import '../infra/database/db_configuration.dart';
import '../models/usuario_model.dart';
import 'dao.dart';

class UsuarioDAO implements DAO<UsuarioModel> {
  final DBConfiguration _dbConfiguration;

  UsuarioDAO(this._dbConfiguration);

  @override
  Future<bool> create(UsuarioModel value) async {
    var result = await _dbConfiguration.execQuery(
      'INSERT INTO usuarios (nome, email, password) VALUES (?, ?, ?)',
      [value.nome, value.email, value.password],
    );

    bool success = result.affectedRows! > 0;

    return success;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration
        .execQuery('DELETE FROM usuarios where id = ?', [id]);
    bool success = result.affectedRows! > 0;

    return success;
  }

  @override
  Future<List<UsuarioModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM usuarios');
    return result
        .map((r) => UsuarioModel.fromMap(r.fields))
        .toList()
        .cast<UsuarioModel>();
  }

  @override
  Future<UsuarioModel?> findOne(int id) async {
    var result = await _dbConfiguration
        .execQuery('SELECT * FROM usuarios where id = ?', [id]);

    var affectedRows = result.affectedRows;

    bool success = affectedRows == 0 ? false : true;

    return success ? UsuarioModel.fromMap(result.first.fields) : null;
  }

  @override
  Future<bool> update(UsuarioModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE usuarios set nome = ?, password = ? where id = ?',
      [value.nome, value.password, value.id],
    );

    bool success = result.affectedRows! > 0;
    return success;
  }

  Future<UsuarioModel?> findByEmail(String email) async {
    var result = await _dbConfiguration
        .execQuery('SELECT * from usuarios where email = ?', [email]);

    return result.affectedRows == 0
        ? null
        : UsuarioModel.fromEmail(result.first.fields);
  }
}
