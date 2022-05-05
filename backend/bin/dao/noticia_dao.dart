import '../infra/database/db_configuration.dart';
import '../models/noticia_model.dart';
import 'dao.dart';

class NoticiaDAO implements DAO<NoticiaModel> {
  final DBConfiguration _dbConfiguration;

  NoticiaDAO(this._dbConfiguration);

  @override
  Future<bool> create(NoticiaModel value) async {
    var result = await _dbConfiguration.execQuery(
      'INSERT INTO noticias (titulo, descricao, id_usuario) VALUES (?, ?, ?)',
      [value.title, value.description, value.userId],
    );

    bool success = result.affectedRows! > 0;

    return success;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration
        .execQuery('DELETE FROM noticias where id = ?', [id]);
    bool success = result.affectedRows! > 0;

    return success;
  }

  @override
  Future<List<NoticiaModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM noticias');
    return result
        .map((r) => NoticiaModel.fromMap(r.fields))
        .toList()
        .cast<NoticiaModel>();
  }

  @override
  Future<NoticiaModel?> findOne(int id) async {
    var result = await _dbConfiguration
        .execQuery('SELECT * FROM noticias where id = ?', [id]);

    bool success = result.isEmpty ? false : true;

    return success ? NoticiaModel.fromMap(result.first.fields) : null;
  }

  @override
  Future<bool> update(NoticiaModel value) async {
    print('Olha ai  update $value ');
    var result = await _dbConfiguration.execQuery(
      'UPDATE noticias set titulo = ?, descricao = ? where id = ?',
      [value.title, value.description, value.id],
    );

    bool success = result.affectedRows! > 0;
    return success;
  }
}
