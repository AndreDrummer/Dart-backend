import 'package:shelf/shelf.dart';

class ModdlewareInterception {
  Middleware get middleware => createMiddleware(
        responseHandler: (Response res) => res.change(
          headers: {
            'content-type': 'application/json',
            'xpto': '123',
          },
        ),
      );
}
