import 'package:free_fire_location/features/map/domain/entities/places_info_entity.dart';

class PlacesInfoModel extends PlacesInfoEntity {
  const PlacesInfoModel({
    required super.latitude,
    required super.longitude,
  });

  factory PlacesInfoModel.fromJson(Map<String, dynamic> json) {
    return PlacesInfoModel(latitude: json['lat'], longitude: json['lng']);
  }
}
