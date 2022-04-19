import 'package:shelf/shelf.dart';
import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/dependency_injector.dart';
import 'infra/middleware_interception.dart';
import 'infra/security/security_service.dart';
import 'infra/security/security_service_imp.dart';
import 'services/noticia_service.dart';
import 'utils/custom_env.dart';

Future<void> main() async {
  CustomEnv.fromfile('.env-dev');

  final _di = DependencyInjector();

  _di.register<SecurityService>(() => SecurityServiceImp());

  var _securityService = _di.get<SecurityService>();

  var cascadeHandler = Cascade()
      .add(LoginApi(_securityService).getHandler())
      .add(
        BlogApi(NoticiaService()).getHandler(
          middlewares: [
            _securityService.authorization,
            _securityService.verifyJwt,
          ],
        ),
      )
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
