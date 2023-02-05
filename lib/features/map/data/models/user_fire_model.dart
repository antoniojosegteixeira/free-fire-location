import 'package:free_fire_location/features/map/domain/entities/user_fire_entity.dart';

class UserFireModel extends UserFireEntity {
  const UserFireModel({
    required super.id,
    required super.latitude,
    required super.longitude,
    required super.date,
  });

  factory UserFireModel.fromJson(json) {
    return UserFireModel(
      id: json["id"] as String,
      latitude: json["latitude"],
      longitude: json["longitude"],
      date: json["date"],
    );
  }
}
