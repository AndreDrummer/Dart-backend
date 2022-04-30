import 'package:mysql1/mysql1.dart';

import '../../utils/custom_env.dart';
import 'db_configuration.dart';

class MySqlDBConfiguration implements DBConfiguration {
  MySqlConnection? _connection;

  @override
  Future<MySqlConnection> get connection async {
    _connection ??= await createConnection();
    if (_connection == null) {
      throw Exception('[ERROR/DB -> Failed Create Connection');
    }
    return _connection!;
  }

  @override
  Future<MySqlConnection> createConnection() async {
    return await MySqlConnection.connect(
      ConnectionSettings(
        password: await CustomEnv.get<String>(key: 'db_pass'),
        host: await CustomEnv.get<String>(key: 'db_host'),
        user: await CustomEnv.get<String>(key: 'db_user'),
        db: await CustomEnv.get<String>(key: 'db_schema'),
        port: await CustomEnv.get<int>(key: 'db_port'),
        characterSet: CharacterSet.UTF8,
      ),
    );
  }
}
