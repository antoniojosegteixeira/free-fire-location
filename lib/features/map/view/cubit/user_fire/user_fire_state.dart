part of 'user_fire_cubit.dart';

abstract class UserFireState extends Equatable {
  const UserFireState();

  @override
  List<Object> get props => [];
}

class UserFireInitial extends UserFireState {}

class UserFireAddFireSuccess extends UserFireState {}

class UserFireAddFireFailure extends UserFireState {}

class UserFireGetFireSuccess extends UserFireState {}

class UserFireGetFireFailure extends UserFireState {}
