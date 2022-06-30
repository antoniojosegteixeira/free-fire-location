part of 'fire_cubit.dart';

@immutable
abstract class FireState {}

class FireInitial extends FireState {}

class FireLoading extends FireState {}

class FireSuccess extends FireState {
  final List<Marker> markers;

  FireSuccess({required this.markers});
}

class FireError extends FireState {
  final Error error;
  FireError({required this.error});
}
