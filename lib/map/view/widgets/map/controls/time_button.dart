import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/map/models/map_types.dart';
import 'package:free_fire_location/map/view/cubit/fire/fire_cubit.dart';
import 'package:free_fire_location/map/view/cubit/options/options_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TimeButton extends StatefulWidget {
  const TimeButton({Key? key}) : super(key: key);

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  String intToString(int value) {
    switch (value) {
      case 1:
        return '10 min';
      case 3:
        return '30 min';
      case 6:
        return '1 hora';
      default:
        return 'Error - out of range';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FireCubit, FireState>(builder: ((context, state) {
      return PopupMenuButton(
          icon: const TimeIcon(),
          iconSize: 55,
          initialValue: BlocProvider.of<FireCubit>(context).numberOfRequests,
          elevation: 16,
          onSelected: (int newValue) {
            BlocProvider.of<FireCubit>(context)
                .changeAmountOfRequests(newValue);
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<int>(
                value: 1,
                child: Text(intToString(1)),
              ),
              PopupMenuItem<int>(
                value: 3,
                child: Text(intToString(3)),
              ),
              PopupMenuItem<int>(
                value: 6,
                child: Text(intToString(6)),
              ),
            ];
          });
    }));
  }
}

class TimeIcon extends StatelessWidget {
  const TimeIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.av_timer_rounded,
        size: 32,
        color: AppColors.white,
      ),
    );
  }
}
