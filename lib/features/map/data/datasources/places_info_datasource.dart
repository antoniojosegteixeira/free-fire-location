import 'dart:convert' as convert;
import 'dart:developer';
import 'package:free_fire_location/core/infra/http_request.dart';
import 'package:free_fire_location/core/infra/request_config/places_info_config.dart';
import 'package:free_fire_location/features/map/data/models/places_info_model.dart';

abstract class PlacesInfoDatasource {
  Future<PlacesInfoModel> getPlacesInfo({required String placeId});
}

class PlacesInfoDatasourceImpl implements PlacesInfoDatasource {
  PlacesInfoDatasourceImpl({required this.client});

  final HttpRequest client;

  @override
  Future<PlacesInfoModel> getPlacesInfo({required String placeId}) async {
    final requestUrl = PlacesInfoConfig().createRequestUrl(placeId: placeId);
    final response = await client.doRequest(
      endpoint: requestUrl,
      requestMethod: RequestMethod.get,
    );

    Map valueMap = convert.jsonDecode(convert.jsonEncode(response.data));
    Map<String, dynamic> mapped = valueMap as Map<String, dynamic>;
    final location = mapped['result']['geometry']['location'];
    final PlacesInfoModel placesInfoResponse =
        PlacesInfoModel.fromJson(location);
    return placesInfoResponse;
  }
}
