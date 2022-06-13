import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:free_fire_location/map/data/response_models/fire_info_response.dart';

class FirePageResponse {
  final coordinatesList;
  FirePageResponse({required this.coordinatesList});

  factory FirePageResponse.fromCsv(dynamic csv) {
    final filteredCsv = const CsvToListConverter(eol: '\n').convert(csv);
    final List<MapInfoResponse> mapInfoList = [];

    for (int i = 1; i < filteredCsv.length; i++) {
      mapInfoList.add(MapInfoResponse.fromCsv(filteredCsv[i]));
    }

    return FirePageResponse(
      coordinatesList: mapInfoList,
    );
  }
}
