import 'package:free_fire_location/core/env/env.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WeatherConfig {
  static const String baseUrl = 'api.weatherapi.com';
  static const String path = '/v1/current.json';

  String createRequestUrl({required LatLng latLng}) {
    final Uri uri = Uri(
        scheme: 'http',
        host: baseUrl,
        path: path,
        queryParameters: {
          'key': Env.weatherKey,
          'q': '${latLng.latitude},${latLng.longitude}'
        });
    return uri.toString();
  }
}
