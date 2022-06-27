part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationOff extends NotificationState {
  final double alertRange;
  NotificationOff({
    required this.alertRange,
  });
}

class NotificationOn extends NotificationState {
  final double alertRange;
  NotificationOn({
    required this.alertRange,
  });
}
