part of 'user_fire_cubit.dart';

@immutable
abstract class UserFireState {}

class UserFireClosed extends UserFireState {}

class UserFireOpen extends UserFireState {
  final LatLng coordinates;

  UserFireOpen({required this.coordinates});
}
