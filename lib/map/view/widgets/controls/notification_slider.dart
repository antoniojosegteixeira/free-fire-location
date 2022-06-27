import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/map/view/cubit/notification/notification_cubit.dart';

class NotificationSlider extends StatelessWidget {
  const NotificationSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              "Alcance (km)",
              style: TextStyle(color: AppColors.white, fontSize: 16),
            ),
          ),
          BlocBuilder<NotificationCubit, NotificationState>(
              builder: ((notificationContext, state) {
            if (state is NotificationInitial) {
              const double currentValue = 1;
              return Slider(
                activeColor: AppColors.primary,
                inactiveColor: AppColors.white,
                value: currentValue,
                min: 0,
                max: 10,
                divisions: 10,
                label: currentValue.round().toString(),
                onChanged: (double value) {
                  BlocProvider.of<NotificationCubit>(notificationContext)
                      .updateRangeValue(value);
                },
              );
            }

            if (state is NotificationOn) {
              return Slider(
                activeColor: AppColors.primary,
                inactiveColor: AppColors.white,
                value: state.alertRange,
                min: 0,
                max: 10,
                divisions: 10,
                label: state.alertRange.round().toString(),
                onChanged: (double value) {
                  BlocProvider.of<NotificationCubit>(notificationContext)
                      .updateRangeValue(value);
                },
              );
            }

            return const Text('error - no widget');
          })),
        ],
      ),
    );
  }
}
