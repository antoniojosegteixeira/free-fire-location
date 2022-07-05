import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:free_fire_location/map/data/response_models/weather_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherRepository {
  final String baseUrl = 'api.weatherapi.com';
  final String path = '/v1/current.json';
  final client = Dio();

  Future<WeatherResponse> getWeatherByCoordinates(LatLng latLng) async {
    final Uri uri =
        Uri(scheme: 'http', host: baseUrl, path: path, queryParameters: {
      'key': dotenv.env['WEATHER_API_KEY'],
      'q': '${latLng.latitude},${latLng.longitude}'
    });

    final response = await client.get(uri.toString());

    final WeatherResponse weatherResponse =
        WeatherResponse.fromJson(response.data, latLng);

    return weatherResponse;
  }
}
