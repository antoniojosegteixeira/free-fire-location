import 'package:free_fire_location/map/models/fire_info.dart';

class MapInfoResponse extends FireInfo {
  MapInfoResponse({
    required super.latitude,
    required super.longitude,
    required super.satelliteName,
    required super.date,
  });

  factory MapInfoResponse.fromCsv(dynamic csv) {
    return MapInfoResponse(
      latitude: csv[0],
      longitude: csv[1],
      satelliteName: csv[2],
      date: csv[3],
    );
  }
}
