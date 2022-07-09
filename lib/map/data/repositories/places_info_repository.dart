import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:free_fire_location/map/data/response_models/places_info_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesInfoRepository {
  final String baseUrl = 'maps.googleapis.com';
  final String path = '/maps/api/place/details/json';
  final client = Dio();

  Future<PlacesInfoResponse?> getPlacesInfo(String placeId) async {
    final Uri uri =
        Uri(scheme: 'https', host: baseUrl, path: path, queryParameters: {
      'key': dotenv.env['GOOGLE_API_KEY'],
      'place_id': placeId,
    });
    try {
      final response = await client.get(uri.toString());
      Map valueMap = convert.jsonDecode(convert.jsonEncode(response.data));
      Map<String, dynamic> mapped = valueMap as Map<String, dynamic>;
      final location = mapped['result']['geometry']['location'];
      final PlacesInfoResponse placesInfoResponse =
          PlacesInfoResponse.fromJson(location);
      return placesInfoResponse;
    } catch (e) {
      print('An error has occured at Info Places API: $e ');
    }
    return null;
  }
}
