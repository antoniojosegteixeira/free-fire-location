import 'package:flutter/material.dart';

@immutable
abstract class NotificationPermissionState {}

class NotificationPermissionOn extends NotificationPermissionState {
  final bool isActivated;

  NotificationPermissionOn({required this.isActivated});
}

class NotificationPermissionOff extends NotificationPermissionState {}
