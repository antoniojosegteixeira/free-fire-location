import 'package:free_fire_location/map/models/weather.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WeatherResponse extends Weather {
  WeatherResponse({
    required super.name,
    required super.region,
    required super.country,
    required super.temperature,
    required super.wind,
    required super.windDir,
    required super.precipitation,
    required super.latitude,
    required super.longitude,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json, LatLng latLng) =>
      WeatherResponse(
        name: json["location"]["name"],
        region: json["location"]["region"],
        country: json["location"]["country"],
        temperature: json["current"]["temp_c"].toDouble(),
        wind: json["current"]["wind_kph"].toDouble(),
        windDir: json["current"]["wind_dir"],
        precipitation: json["current"]["precip_mm"].toDouble(),
        latitude: latLng.latitude,
        longitude: latLng.longitude,
      );
}
