import 'package:equatable/equatable.dart';

class PlacesInfoEntity extends Equatable {
  final double latitude;
  final double longitude;

  const PlacesInfoEntity({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];
}
