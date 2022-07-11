import 'package:free_fire_location/map/models/user_fire.dart';

class UserFireResponse extends UserFire {
  UserFireResponse({
    required super.id,
    required super.latitude,
    required super.longitude,
    required super.date,
  });

  factory UserFireResponse.fromJson(json) {
    return UserFireResponse(
      id: int.parse(json['id']),
      latitude: json["latitude"],
      longitude: json["longitude"],
      date: json["data"] as String,
    );
  }
}
