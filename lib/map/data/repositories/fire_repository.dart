import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:free_fire_location/map/data/response_models/fire_page_response.dart';
import 'package:free_fire_location/map/models/file_name.dart';

class FireRepository {
  final String baseUrl = 'queimadas.dgi.inpe.br';
  final String username = 'dados_abertos';
  final String password = 'dados_abertos';

  final client = Dio();

  Future<FirePageResponse> getFireLocations(int amount) async {
    final String auth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    List<Future> requests = [];

    for (int i = amount; i >= 0; i--) {
      final uri = Uri.https(baseUrl,
          "queimadas/users/dados_abertos/focos/10min/${FileName.getPastFileName(i)}");
      requests.add(client.get(
        uri.toString(),
        options: Options(headers: <String, String>{'authorization': auth}),
      ));
    }

    final List response = await Future.wait(requests);

    final FirePageResponse pageResponse =
        FirePageResponse.fromCsvList(response);

    return pageResponse;
  }
}
