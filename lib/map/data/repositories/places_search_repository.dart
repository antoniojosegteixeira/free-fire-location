import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert' as convert;
import 'package:free_fire_location/map/data/response_models/places_search_response.dart';

class PlacesSearchRepository {
  final String baseUrl = 'maps.googleapis.com';
  final String path = '/maps/api/place/autocomplete/json';
  final client = Dio();

  Future<List<PlacesSearchResponse>> getAutoCompletePlaces(String input) async {
    final Uri uri =
        Uri(scheme: 'http', host: baseUrl, path: path, queryParameters: {
      'input': input,
      'language': 'pt_br',
      'types': '(cities)',
      'key': dotenv.env['WEATHER_API_KEY'],
    });
    try {
      final response = await client.get(uri.toString());
      final json = convert.jsonDecode(response.data.body);
      final predictions = json['predictions'] as List;

      return predictions
          .map((place) => PlacesSearchResponse.fromJson(place))
          .toList();
    } catch (e) {
      print(e);
    }
    throw Error();
  }
}
