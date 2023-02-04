import 'package:free_fire_location/core/infra/http_request.dart';
import 'package:free_fire_location/core/infra/request_config/nasa_config.dart';
import 'package:free_fire_location/features/map/data/datasources/fire_info_datasource.dart';
import 'package:free_fire_location/features/map/data/models/fire_page_response.dart';

class FireInfoDatasourceNasa implements FireInfoDatasource {
  FireInfoDatasourceNasa({required this.client});

  final HttpRequest client;

  @override
  Future<FirePageModel> getFireLocations({required int amount}) async {
    String requestUrl = NasaConfig().createRequestUrl();
    final response = await client.doRequest(
      endpoint: requestUrl,
      requestMethod: RequestMethod.get,
    );

    final FirePageModel pageResponse = FirePageModel.fromNasaCsv(response.data);

    return pageResponse;
  }
}
