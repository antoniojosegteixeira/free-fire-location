import 'dart:convert' as convert;
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:free_fire_location/features/map/data/models/places_autocomplete_model.dart';
import 'package:free_fire_location/features/map/domain/entities/places_autocomplete_entity.dart';

abstract class PlacesAutocompleteDatasource {
  Future<List<PlacesAutocompleteEntity>> getPlacesAutocomplete(
      {required String input});
}

class PlacesAutocompleteDatasourceImpl implements PlacesAutocompleteDatasource {
  PlacesAutocompleteDatasourceImpl();

  final String baseUrl = 'maps.googleapis.com';
  final String path = '/maps/api/place/autocomplete/json';
  final client = Dio();

  @override
  Future<List<PlacesAutocompleteEntity>> getPlacesAutocomplete(
      {required String input}) async {
    final Uri uri =
        Uri(scheme: 'https', host: baseUrl, path: path, queryParameters: {
      'input': input,
      'language': 'pt_br',
      'types': '(cities)',
      'key': dotenv.env['GOOGLE_API_KEY'],
    });

    final response = await client.get(uri.toString());
    Map valueMap = convert.jsonDecode(convert.jsonEncode(response.data));
    Map<String, dynamic> mapped = valueMap as Map<String, dynamic>;
    List predictions = mapped["predictions"];

    final result = predictions
        .map<PlacesAutocompleteEntity>(
          (place) => PlacesAutocompleteModel.fromJson(place),
        )
        .toList();

    return result;
  }
}
