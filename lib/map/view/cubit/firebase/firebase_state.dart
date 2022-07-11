import 'package:flutter/material.dart';
import 'package:free_fire_location/map/data/response_models/user_fire_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@immutable
abstract class FirebaseState {}

class FirebaseLoading extends FirebaseState {}

class FirebaseSuccess extends FirebaseState {
  final List<UserFireResponse> userFireList;
  final BitmapDescriptor userMarkerImage;
  FirebaseSuccess({
    required this.userFireList,
    required this.userMarkerImage,
  });
}

class FirebaseError extends FirebaseState {
  final Error error;
  FirebaseError({required this.error});
}
