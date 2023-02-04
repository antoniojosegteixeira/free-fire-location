import 'package:free_fire_location/features/map/domain/entities/weather_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
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

  factory WeatherModel.fromJson(Map<String, dynamic> json, LatLng latLng) =>
      WeatherModel(
        name: json["location"]["name"].toString().trim(),
        region: json["location"]["region"].toString().trim(),
        country: json["location"]["country"].toString().trim(),
        temperature: json["current"]["temp_c"].toDouble(),
        wind: json["current"]["wind_kph"].toDouble(),
        windDir: json["current"]["wind_dir"],
        precipitation: json["current"]["precip_mm"].toDouble(),
        latitude: latLng.latitude,
        longitude: latLng.longitude,
      );
}
