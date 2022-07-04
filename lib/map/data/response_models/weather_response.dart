import 'package:free_fire_location/map/models/weather.dart';

class WeatherResponse extends Weather {
  WeatherResponse({
    required super.name,
    required super.region,
    required super.country,
    required super.temperature,
    required super.wind,
    required super.windDir,
    required super.precipitation,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      WeatherResponse(
        name: json["location"]["name"],
        region: json["location"]["region"],
        country: json["location"]["country"],
        temperature: json["current"]["temp_c"].toDouble(),
        wind: json["current"]["wind_kph"].toDouble(),
        windDir: json["current"]["wind_dir"],
        precipitation: json["current"]["precip_mm"].toDouble(),
      );
}
