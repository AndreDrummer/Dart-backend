import 'package:shelf/shelf.dart';
import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/dependency_injector.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service.dart';
import 'infra/security/security_service_imp.dart';
import 'services/noticia_service.dart';
import 'utils/custom_env.dart';

Future<void> main() async {
  CustomEnv.fromfile('.env-dev');

  final _di = Injects.initialize();

  var _securityService = _di.get<SecurityService>();

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
