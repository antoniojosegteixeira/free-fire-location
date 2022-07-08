import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert' as convert;
import 'package:free_fire_location/map/data/response_models/places_search_response.dart';

class PlacesSearchRepository {
  final String baseUrl = 'maps.googleapis.com';
  final String path = '/maps/api/place/autocomplete/json';
  final client = Dio();

  Future<List> getAutoCompletePlaces(String input) async {
    final Uri uri =
        Uri(scheme: 'https', host: baseUrl, path: path, queryParameters: {
      'input': input,
      'language': 'pt_br',
      'types': '(cities)',
      'key': dotenv.env['GOOGLE_API_KEY'],
    });
    try {
      final response = await client.get(uri.toString());
      Map valueMap = convert.jsonDecode(convert.jsonEncode(response.data));
      Map<String, dynamic> mapped = valueMap as Map<String, dynamic>;
      List predictions = mapped["predictions"];

      return predictions
          .map((place) => PlacesSearchResponse.fromJson(place))
          .toList();
    } catch (e) {
      print('An error has occured $e');
      return [];
    }
  }
}
