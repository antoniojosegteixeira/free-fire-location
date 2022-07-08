part of 'map_controller_cubit.dart';

@immutable
abstract class MapControllerState {}

class MapControllerInitial extends MapControllerState {}

class MapControllerCompleted extends MapControllerState {
  final GoogleMapController activeController;
  MapControllerCompleted({required this.activeController});
}
