import 'package:free_fire_location/core/env/env.dart';

class PlacesInfoConfig {
  final String baseUrl = 'maps.googleapis.com';
  final String path = '/maps/api/place/details/json';

  String createRequestUrl({
    required String placeId,
  }) {
    final Uri uri =
        Uri(scheme: 'https', host: baseUrl, path: path, queryParameters: {
      'key': Env.googleMapsKey,
      'place_id': placeId,
    });
    return uri.toString();
  }
}
