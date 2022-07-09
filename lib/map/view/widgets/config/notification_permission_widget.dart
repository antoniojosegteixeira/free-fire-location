import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';

class NotificationPermissionWidget extends StatefulWidget {
  const NotificationPermissionWidget({Key? key}) : super(key: key);

  @override
  State<NotificationPermissionWidget> createState() =>
      _NotificationPermissionWidgetState();
}

class _NotificationPermissionWidgetState
    extends State<NotificationPermissionWidget> {
  //
  bool isNotificationOn = false;

  @override
  void initState() {
    super.initState();
    _toggleButton();
  }

  void _toggleButton() {
    AwesomeNotifications().isNotificationAllowed().then((bool isAllowed) => {
          setState(() {
            isNotificationOn = isAllowed;
          }),
        });
  }

  void _toggleNotification() {
    AwesomeNotifications().isNotificationAllowed().then(
          (isAllowed) => {
            if (!isAllowed)
              {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Ativar notificações"),
                    content: const Text(
                        "Deseja ativar as notificações de incêndios próximos?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Não permitir")),
                      TextButton(
                          onPressed: () {
                            AwesomeNotifications()
                                .requestPermissionToSendNotifications()
                                .then((bool result) {
                              setState(() {
                                isNotificationOn = result ? true : false;
                              });
                              Navigator.pop(context);
                            });
                          },
                          child: const Text("Permitir"))
                    ],
                  ),
                ),
              }
            else if (isAllowed)
              {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Desativar notificações"),
                    content: const Text(
                        "Deseja desativar as notificações de incêndios próximos?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Não")),
                      TextButton(
                          onPressed: () {
                            AwesomeNotifications()
                                .showNotificationConfigPage()
                                .then((_) async {
                              Navigator.pop(context);
                              _toggleButton();
                            });
                          },
                          child: const Text("Sim"))
                    ],
                  ),
                ),
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Notificações',
              style: TextStyle(color: AppColors.white, fontSize: 17.0),
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Switch(
                activeColor: AppColors.primary,
                value: isNotificationOn,
                onChanged: (bool newValue) {
                  _toggleNotification();
                },
              ),
            ),
            const Flexible(
              child: Text(
                'Desejo ser notificado em caso de incêndio próximo',
                style: TextStyle(color: AppColors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
