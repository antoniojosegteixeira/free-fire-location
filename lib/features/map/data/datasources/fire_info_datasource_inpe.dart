import 'package:free_fire_location/core/infra/http_request.dart';
import 'package:free_fire_location/core/infra/request_config/inpe_config.dart';
import 'package:free_fire_location/features/map/data/datasources/fire_info_datasource.dart';
import 'package:free_fire_location/features/map/data/models/fire_page_response.dart';
import 'package:free_fire_location/utils/file_name.dart';

class FireInfoDatasourceInpe implements FireInfoDatasource {
  FireInfoDatasourceInpe({required this.client});

  final HttpRequest client;

  @override
  Future<FirePageModel> getFireLocations({required int amount}) async {
    List<Future> requests = [];

    for (int i = amount; i >= 1; i--) {
      final uri = Uri.https(InpeConfig.baseUrl,
          "queimadas/users/dados_abertos/focos/10min/${FileName.getPastFileName(i)}");
      requests.add(client.doRequest(
          endpoint: uri.toString(),
          requestMethod: RequestMethod.get,
          headers: <String, dynamic>{'authorization': InpeConfig.auth}));
    }

    final List response = await Future.wait(requests);

    final FirePageModel pageResponse = FirePageModel.fromCsvList(response);

    return pageResponse;
  }
}
