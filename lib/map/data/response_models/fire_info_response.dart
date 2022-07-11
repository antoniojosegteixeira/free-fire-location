import 'package:free_fire_location/map/models/fire_info.dart';

class FireInfoResponse extends FireInfo {
  FireInfoResponse({
    required super.latitude,
    required super.longitude,
    required super.satelliteName,
    required super.date,
  });

  factory FireInfoResponse.fromNasaCsv(dynamic csv) {
    return FireInfoResponse(
      latitude: csv[1],
      longitude: csv[2],
      satelliteName: csv[9],
      date: csv[6],
    );
  }

  factory FireInfoResponse.fromCsv(dynamic csv) {
    return FireInfoResponse(
      latitude: csv[0],
      longitude: csv[1],
      satelliteName: csv[2],
      date: csv[3],
    );
  }
}
