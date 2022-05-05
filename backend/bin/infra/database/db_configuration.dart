import 'package:mysql1/mysql1.dart';

abstract class DBConfiguration {
  Future<dynamic> createConnection();

  Future<Results> execQuery(String sql, [List params]);

  Future<dynamic> get connection;
}
