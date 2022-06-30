import 'package:csv/csv.dart';
import 'package:free_fire_location/map/data/response_models/fire_info_response.dart';
import 'package:free_fire_location/map/models/fire_page.dart';
import 'package:free_fire_location/utils/filter_markers.dart';

class FirePageResponse extends FirePage {
  FirePageResponse({required super.coordinatesList});

  factory FirePageResponse.fromCsvList(List<dynamic> csvList) {
    List filteredList = [];
    final List<MapInfoResponse> mapInfoList = [];

    for (int i = 0; i < csvList.length; i++) {
      final filteredCsv =
          const CsvToListConverter(eol: '\n').convert(csvList[0].data);
      filteredCsv.removeAt(0);
      filteredList = [...filteredList, ...filteredCsv];
    }

    for (int i = 1; i < filteredList.length; i++) {
      // Check if it's inside Brazil
      for (int y = 0; y < filteredList[i].length; y++) {
        bool isFireLocatedInBrazil = FilterMarkers.isFireLocatedInBrazil(
          lat: filteredList[i][0],
          lon: filteredList[i][1],
        );

        if (isFireLocatedInBrazil == true) {
          mapInfoList.add(MapInfoResponse.fromCsv(filteredList[i]));
        }
      }
    }

    return FirePageResponse(
      coordinatesList: mapInfoList,
    );
  }
}
