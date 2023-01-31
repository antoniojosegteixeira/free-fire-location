import 'package:free_fire_location/core/env/env.dart';

class NasaConfig {
  static const String baseUrl = 'firms.modaps.eosdis.nasa.gov';
  String key = Env.nasaKey;

  String _generateDateString() {
    DateTime dateNow = DateTime.now();
    String year = dateNow.year.toString();
    String month = dateNow.month.toString().padLeft(2, '0');
    String day = dateNow.day.toString().padLeft(2, '0');

    return "$year-$month-$day";
  }

  String createRequestUrl() {
    final uri = Uri.https(baseUrl,
        "/api/country/csv/$key/VIIRS_SNPP_NRT/BRA/1/${_generateDateString()}");

    return uri.toString();
  }
}
