import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarker {
  final double latitude;
  final double longitude;
  final String satelliteName;
  final String date;

  MapMarker({
    required this.latitude,
    required this.longitude,
    required this.satelliteName,
    required this.date,
  });
}
