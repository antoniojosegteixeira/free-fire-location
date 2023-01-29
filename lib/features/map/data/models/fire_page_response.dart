import 'package:csv/csv.dart';
import 'package:free_fire_location/features/map/data/models/fire_info_response.dart';
import 'package:free_fire_location/features/map/domain/entities/fire_info_entity.dart';
import 'package:free_fire_location/features/map/domain/entities/fire_page_entity.dart';
import 'package:free_fire_location/utils/filter_markers.dart';

class FirePageModel extends FirePageEntity {
  const FirePageModel({required super.coordinatesList});

  factory FirePageModel.fromCsv(dynamic csv) {
    final filteredCsv = const CsvToListConverter(eol: '\n').convert(csv);
    final List<FireInfoEntity> mapInfoList = [];

    if (filteredCsv.length > 1) {
      for (int i = 1; i < filteredCsv.length; i++) {
        mapInfoList.add(FireInfoModel.fromCsv(filteredCsv[i]));
      }
    }

    return FirePageModel(
      coordinatesList: mapInfoList,
    );
  }

  factory FirePageModel.fromCsvList(List<dynamic> csvList) {
    List filteredList = [];
    final List<FireInfoEntity> mapInfoList = [];

    for (int i = 0; i < csvList.length; i++) {
      final filteredCsv =
          const CsvToListConverter(eol: '\n').convert(csvList[i].data);
      filteredCsv.removeAt(0);
      filteredList = [...filteredList, ...filteredCsv];
    }

    for (int i = 1; i < filteredList.length; i++) {
      // Check if it's inside Brazil

      bool isFireLocatedInBrazil = FilterMarkers.isFireLocatedInBrazil(
        lat: filteredList[i][0],
        lon: filteredList[i][1],
      );

      if (isFireLocatedInBrazil) {
        mapInfoList.add(FireInfoModel.fromCsv(filteredList[i]));
      }
    }
    return FirePageModel(
      coordinatesList: mapInfoList,
    );
  }
}
