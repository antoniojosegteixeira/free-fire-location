part of 'notification_range_cubit.dart';

@immutable
abstract class NotificationRangeState {}

class NotificationRangeInitial extends NotificationRangeState {}

class NotificationRangeOff extends NotificationRangeState {
  final NotificationOptionsResponse options;
  NotificationRangeOff({
    required this.options,
  });
}

class NotificationRangeOn extends NotificationRangeState {
  final NotificationOptionsResponse options;
  NotificationRangeOn({
    required this.options,
  });
}
