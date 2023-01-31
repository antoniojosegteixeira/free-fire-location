import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get googleMapsKey => dotenv.env['GOOGLE_API_KEY'] as String;
  static String get nasaKey => dotenv.env['NASA_API_KEY'] as String;
  static String get weatherKey => dotenv.env['WEATHER_API_KEY'] as String;
}
