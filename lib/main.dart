import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/notifications/check_nearby_fires.dart';
import 'package:free_fire_location/firebase_options.dart';
import 'package:free_fire_location/my_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void initializeNotifications() {
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
            channelGroupKey: 'fire_notifications',
            channelKey: 'close_fires_notification',
            channelName: 'Notificações de proximidade de incêndios',
            channelDescription:
                'Canal de notificações para alerta de incêndios próximos',
            defaultColor: AppColors.darkBrown,
            ledColor: AppColors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'fire_channel_group',
            channelGroupName: 'Grupo - Incêndios')
      ],
      debug: true);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
