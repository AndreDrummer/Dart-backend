import 'package:shelf/shelf.dart';

import '../infra/dependency_injector/dependency_injector.dart';
import '../infra/security/security_service.dart';

abstract class Api {
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity,
  });

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    middlewares ??= [];

    var _securityService = DependencyInjector().get<SecurityService>();

    if (isSecurity) {
      middlewares.addAll([
        _securityService.authorization,
        _securityService.verifyJwt,
      ]);
    }

    var pipe = Pipeline();

    middlewares.forEach((m) => pipe = pipe.addMiddleware(m));

    return pipe.addHandler(router);
  }
}
