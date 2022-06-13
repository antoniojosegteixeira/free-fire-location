import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:free_fire_location/map/data/response_models/fire_page_response.dart';
import 'package:free_fire_location/map/models/file_name.dart';

class FireRepository {
  final baseUrl = 'queimadas.dgi.inpe.br';
  final client = Dio();

  Future<FirePageResponse> getFireLocations() async {
    String username = 'dados_abertos';
    String password = 'dados_abertos';
    String auth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final uri = Uri.https(baseUrl,
        "queimadas/users/dados_abertos/focos/10min/${FileName.getFileName()}");

    final response = await client.get(
      uri.toString(),
      options: Options(headers: <String, String>{'authorization': auth}),
    );
    return FirePageResponse.fromCsv(response.data);
  }
}
