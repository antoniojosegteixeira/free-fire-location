import 'package:equatable/equatable.dart';

class UserFireEntity extends Equatable {
  final String id;
  final double latitude;
  final double longitude;
  final String date;

  const UserFireEntity({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.date,
  });

  @override
  List<Object?> get props => [
        id,
        latitude,
        longitude,
        date,
      ];
}
