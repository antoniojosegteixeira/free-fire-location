part of 'fire_cubit.dart';

@immutable
abstract class FireState {}

class FireInitial extends FireState {}

class FireLoading extends FireState {}

class FireSuccess extends FireState {
  final BitmapDescriptor markerImage;
  final BitmapDescriptor userMarkerImage;
  final List<FireInfo> coordinatesList;

  FireSuccess({
    required this.coordinatesList,
    required this.userMarkerImage,
    required this.markerImage,
  });
}

class FireError extends FireState {
  final Error error;
  FireError({required this.error});
}
