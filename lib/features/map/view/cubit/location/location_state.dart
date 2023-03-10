import 'package:geolocator/geolocator.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationEnabled extends LocationState {
  late Position position;
  LocationEnabled({required this.position});
}

class LocationDisabled extends LocationState {}
