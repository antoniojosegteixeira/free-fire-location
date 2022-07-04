import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:free_fire_location/consts/weather_auth.dart';
import 'package:free_fire_location/map/data/response_models/weather_response.dart';

class WeatherRepository {
  final String baseUrl = 'api.weatherapi.com/v1/current.json';
  final String path = '/current.json/';
  final client = Dio();

  Future<WeatherResponse> getWeatherByCoordinates(
      {required double lat, required double lon}) async {
    final Uri uri = Uri(
        scheme: 'https',
        host: baseUrl,
        path: path,
        queryParameters: {'key': WeatherAuth.apiKey, 'q': '$lat, $lon'});

    final response = await client.get(uri.toString());

    final WeatherResponse weatherResponse =
        WeatherResponse.fromJson(response.data);

    return weatherResponse;
  }
}
