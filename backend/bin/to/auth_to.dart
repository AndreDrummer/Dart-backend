import 'dart:convert';

class AuthTO {
  final String password;
  final String email;

  AuthTO(this.password, this.email);

  factory AuthTO.fromRequest(String body) {
    var map = jsonDecode(body);
    return AuthTO(
      map['password'],
      map['email'],
    );
  }
}
