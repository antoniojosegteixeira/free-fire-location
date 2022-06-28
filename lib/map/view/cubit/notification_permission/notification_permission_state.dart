abstract class NotificationPermissionState {}

class NotificationPermissionOn extends NotificationPermissionState {
  bool isActivated;

  NotificationPermissionOn({required this.isActivated});
}

class NotificationPermissionOff extends NotificationPermissionState {}
