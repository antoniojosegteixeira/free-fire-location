import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:free_fire_location/map/data/response_models/places_search_response.dart';

class PlacesSearchRepository {
  final String baseUrl = 'maps.googleapis.com';
  final String path = '/maps/api/place/autocomplete/json';
  final client = Dio();

  Future<PlacesSearchResponse> getPlaces(String input) async {
    final Uri uri =
        Uri(scheme: 'http', host: baseUrl, path: path, queryParameters: {
      'input': input,
      'language': 'pt_br',
      'types': '%28cities%29',
      'key': dotenv.env['WEATHER_API_KEY'],
    });

    final response = await client.get(uri.toString());

    PlacesSearchResponse placesSearchResponse =
        PlacesSearchResponse.fromJson(response.data);
    return placesSearchResponse;
  }
}
