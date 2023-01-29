import 'package:equatable/equatable.dart';

class FireInfoEntity extends Equatable {
  final double latitude;
  final double longitude;
  final String satelliteName;
  final String date;

  const FireInfoEntity({
    required this.latitude,
    required this.longitude,
    required this.satelliteName,
    required this.date,
  });

  @override
  List<Object> get props => [
        latitude,
        longitude,
        satelliteName,
        date,
      ];
}
