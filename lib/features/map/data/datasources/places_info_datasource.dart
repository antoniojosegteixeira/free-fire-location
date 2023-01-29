import 'dart:convert' as convert;
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:free_fire_location/features/map/data/models/places_info_model.dart';

abstract class PlacesInfoDatasource {
  Future<PlacesInfoModel> getPlacesInfo({required String placeId});
}

class PlacesInfoDatasourceImpl implements PlacesInfoDatasource {
  PlacesInfoDatasourceImpl();

  final String baseUrl = 'maps.googleapis.com';
  final String path = '/maps/api/place/details/json';
  final client = Dio();

  @override
  Future<PlacesInfoModel> getPlacesInfo({required String placeId}) async {
    final Uri uri =
        Uri(scheme: 'https', host: baseUrl, path: path, queryParameters: {
      'key': dotenv.env['GOOGLE_API_KEY'],
      'place_id': placeId,
    });

    final response = await client.get(uri.toString());

    Map valueMap = convert.jsonDecode(convert.jsonEncode(response.data));
    Map<String, dynamic> mapped = valueMap as Map<String, dynamic>;
    final location = mapped['result']['geometry']['location'];
    final PlacesInfoModel placesInfoResponse =
        PlacesInfoModel.fromJson(location);
    return placesInfoResponse;
  }
}
