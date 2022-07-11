import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:free_fire_location/map/data/response_models/fire_page_response.dart';
import 'package:free_fire_location/map/models/file_name.dart';

class FireRepository {
  final String baseUrl = 'firms.modaps.eosdis.nasa.gov';

  final client = Dio();

  Future<FirePageResponse> getFireLocations() async {
    List<Future> requests = [];
    DateTime dateNow = DateTime.now();
    String year = dateNow.year.toString();
    String month = dateNow.month.toString().padLeft(2, '0');
    String day = dateNow.day.toString().padLeft(2, '0');

    String key = 'c173c8f56ff3f081c173173ee3fc251e';

    final uri = Uri.https(baseUrl,
        "/api/country/csv/$key/VIIRS_SNPP_NRT/BRA/1/$year-$month-$day");

    final response = await client.get(uri.toString());

    final FirePageResponse pageResponse =
        FirePageResponse.fromCsv(response.data);

    return pageResponse;
  }
}
