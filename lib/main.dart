import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/notifications/check_nearby_fires.dart';
import 'package:free_fire_location/firebase_options.dart';
import 'package:free_fire_location/my_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:free_fire_location/notifications/notifications.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    CheckNearbyFires().startFireNotification();
    return Future.value(true);
  });
}

void initializeBackgroundRequests() {
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  Workmanager().registerPeriodicTask("id", "show-notification");
}

Future<void> initializeNotifications() async {
  await AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    null,
    [
      NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Notificações de proximidade de incêndios',
          channelDescription:
              'Canal de notificações para alerta de incêndios próximos',
          defaultColor: AppColors.darkBrown,
          ledColor: AppColors.white)
    ],
    // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
          channelGroupkey: 'basic_channel_group',
          channelGroupName: 'Basic group')
    ],
    debug: true,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await initializeNotifications();

  initializeBackgroundRequests();
  CheckNearbyFires().startFireNotification();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
