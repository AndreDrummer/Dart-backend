import 'package:shelf/shelf.dart';

import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/middleware_interception.dart';
import 'services/noticia_service.dart';
import 'utils/custom_env.dart';

Future<void> main() async {
  CustomEnv.fromfile('.env-dev');

  var cascadeHandler = Cascade()
      .add(LoginApi().handler)
      .add(BlogApi(NoticiaService()).handler)
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(ModdlewareInterception().middleware)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
    address: await CustomEnv.get<String>(key: 'server_address'),
    port: await CustomEnv.get<int>(key: 'server_port'),
    handler: handler,
  );
}
