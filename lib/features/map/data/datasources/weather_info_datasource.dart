import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:free_fire_location/features/map/data/models/weather_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class WeatherInfoDatasource {
  Future<WeatherModel> getWeatherByCoordinates({
    required LatLng latLng,
  });
}

class WeatherInfoDatasourceImpl implements WeatherInfoDatasource {
  WeatherInfoDatasourceImpl();

  final client = Dio();
  final String baseUrl = 'api.weatherapi.com';
  final String path = '/v1/current.json';

  @override
  Future<WeatherModel> getWeatherByCoordinates({required LatLng latLng}) async {
    final Uri uri =
        Uri(scheme: 'http', host: baseUrl, path: path, queryParameters: {
      'key': dotenv.env['WEATHER_API_KEY'],
      'q': '${latLng.latitude},${latLng.longitude}'
    });

    final response = await client.get(uri.toString());

    final WeatherModel weatherResponse =
        WeatherModel.fromJson(response.data, latLng);

    return weatherResponse;
  }
}
