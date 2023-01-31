import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:free_fire_location/features/map/data/datasources/fire_info_datasource.dart';
import 'package:free_fire_location/features/map/data/models/fire_page_response.dart';
import 'package:free_fire_location/utils/file_name.dart';

class FireInfoDatasourceInpe implements FireInfoDatasource {
  FireInfoDatasourceInpe();

  final client = Dio();

  @override
  Future<FirePageModel> getFireLocations({required int amount}) async {
    const String baseUrl = 'queimadas.dgi.inpe.br';
    const String username = 'dados_abertos';
    const String password = 'dados_abertos';

    final String auth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    List<Future> requests = [];

    for (int i = amount; i >= 1; i--) {
      final uri = Uri.https(baseUrl,
          "queimadas/users/dados_abertos/focos/10min/${FileName.getPastFileName(i)}");
      requests.add(client.get(
        uri.toString(),
        options: Options(headers: <String, String>{'authorization': auth}),
      ));
    }

    final List response = await Future.wait(requests);

    final FirePageModel pageResponse = FirePageModel.fromCsvList(response);

    return pageResponse;
  }
}
