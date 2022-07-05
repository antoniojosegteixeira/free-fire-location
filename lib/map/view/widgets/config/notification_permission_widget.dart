import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/map/view/cubit/notification_permission/notification_permission_cubit.dart';
import 'package:free_fire_location/map/view/cubit/notification_permission/notification_permission_state.dart';

class NotificationPermissionWidget extends StatefulWidget {
  const NotificationPermissionWidget({Key? key}) : super(key: key);

  @override
  State<NotificationPermissionWidget> createState() =>
      _NotificationPermissionWidgetState();
}

class _NotificationPermissionWidgetState
    extends State<NotificationPermissionWidget> {
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
        BlocBuilder<NotificationPermissionCubit, NotificationPermissionState>(
          builder: ((notificationPermissionContext, state) {
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Switch(
                    activeColor: AppColors.primary,
                    value: state is NotificationPermissionOn,
                    onChanged: (bool newValue) {
                      BlocProvider.of<NotificationPermissionCubit>(
                              notificationPermissionContext)
                          .updatePermissionValue(newValue);
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
            );
          }),
        ),
      ],
    );
  }
}
