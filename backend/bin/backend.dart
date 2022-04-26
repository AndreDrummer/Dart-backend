import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';
import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';

Future<void> main() async {
  CustomEnv.fromfile('.env-dev');

  var connection = await MySqlConnection.connect(
    ConnectionSettings(
      password: await CustomEnv.get<String>(key: 'db_pass'),
      host: await CustomEnv.get<String>(key: 'db_host'),
      user: await CustomEnv.get<String>(key: 'db_user'),
      db: await CustomEnv.get<String>(key: 'db_schema'),
      port: await CustomEnv.get<int>(key: 'db_port'),
      characterSet: CharacterSet.UTF8,
    ),
  );

  var result = await connection.query('SELECT * FROM usuarios');
  print(result);

  final _di = Injects.initialize();

  var cascadeHandler = Cascade()
      .add(_di.get<LoginApi>().getHandler())
      .add(_di.get<BlogApi>().getHandler(isSecurity: true))
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(ModdlewareInterception().mimeTypeApplication)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
    handler: handler,
  );
}
