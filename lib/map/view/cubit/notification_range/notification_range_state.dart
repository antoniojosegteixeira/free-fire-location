part of 'notification_range_cubit.dart';

@immutable
abstract class NotificationRangeState {}

class NotificationRangeInitial extends NotificationRangeState {}

class NotificationRangeOff extends NotificationRangeState {
  final double alertRange;
  NotificationRangeOff({
    required this.alertRange,
  });
}

class NotificationRangeOn extends NotificationRangeState {
  final double alertRange;
  NotificationRangeOn({
    required this.alertRange,
  });
}
