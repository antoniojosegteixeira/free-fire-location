import 'package:free_fire_location/core/env/env.dart';

class PlacesConfig {
  static const String baseUrl = 'maps.googleapis.com';
  static const String path = '/maps/api/place/autocomplete/json';
  String key = Env.googleMapsKey;

  String createRequestUrl(String input) {
    final Uri uri =
        Uri(scheme: 'https', host: baseUrl, path: path, queryParameters: {
      'input': input,
      'language': 'pt_br',
      'types': '(cities)',
      'key': Env.googleMapsKey,
    });

    return uri.toString();
  }
}
