import 'package:free_fire_location/features/map/domain/entities/fire_info_entity.dart';

class FireInfoModel extends FireInfoEntity {
  const FireInfoModel({
    required super.latitude,
    required super.longitude,
    required super.satelliteName,
    required super.date,
  });

  factory FireInfoModel.fromNasaCsv(dynamic csv) {
    return FireInfoModel(
      latitude: csv[1],
      longitude: csv[2],
      satelliteName: csv[9].toString().trim(),
      date: csv[6].toString().trim(),
    );
  }

  factory FireInfoModel.fromCsv(dynamic csv) {
    return FireInfoModel(
      latitude: csv[0],
      longitude: csv[1],
      satelliteName: csv[2].toString().trim(),
      date: csv[3].toString().trim(),
    );
  }
}
