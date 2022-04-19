import 'package:shelf/shelf.dart';

class ModdlewareInterception {
  Middleware get mimeTypeApplication => createMiddleware(
        responseHandler: (Response res) => res.change(
          headers: {
            'content-type': 'application/json',
          },
        ),
      );
}
