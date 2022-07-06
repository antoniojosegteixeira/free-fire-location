import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> createFireNotification(int number) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 4,
      channelKey: 'basic_channel',
      title: '${Emojis.wheater_fire} Incêndio próximo!',
      body: '$number incêndios próximos de você!',
      notificationLayout: NotificationLayout.BigText,
    ),
  );
}
