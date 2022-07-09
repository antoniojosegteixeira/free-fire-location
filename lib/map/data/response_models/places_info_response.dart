import 'package:free_fire_location/map/models/places_info.dart';

class PlacesInfoResponse extends PlacesInfo {
  PlacesInfoResponse({
    required super.latitude,
    required super.longitude,
  });

  factory PlacesInfoResponse.fromJson(Map<String, dynamic> json) {
    return PlacesInfoResponse(latitude: json['lat'], longitude: json['lng']);
  }
}
