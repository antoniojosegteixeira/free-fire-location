import 'dart:convert';

class InpeConfig {
  static const String baseUrl = 'queimadas.dgi.inpe.br';
  static const String username = 'dados_abertos';
  static const String password = 'dados_abertos';

  static String get auth =>
      'Basic ${base64Encode(utf8.encode('$username:$password'))}';
}
