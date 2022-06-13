part of 'fire_cubit.dart';

@immutable
abstract class FireState {}

class FireInitial extends FireState {}

class FireLoading extends FireState {}

class FireSuccess extends FireState {
  final FirePageResponse fireInfo;
  FireSuccess({required this.fireInfo});
}

class FireError extends FireState {}
