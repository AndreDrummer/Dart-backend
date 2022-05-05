import 'package:shelf/shelf.dart';
import 'apis/noticias_api.dart';
import 'apis/login_api.dart';
import 'apis/usuario_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';

Future<void> main() async {
  CustomEnv.fromfile('.env-dev');

  final _di = Injects.initialize();

  var cascadeHandler = Cascade()
      .add(_di<LoginApi>().getHandler())
      .add(_di<NoticiasApi>().getHandler(isSecurity: true))
      .add(_di<UsuarioApi>().getHandler(isSecurity: true))
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
