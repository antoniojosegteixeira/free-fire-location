import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/features/map/view/cubit/fire/fire_cubit.dart';

class TimeButton extends StatefulWidget {
  const TimeButton({Key? key}) : super(key: key);

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  String intToString(int value) {
    switch (value) {
      case 2:
        return '30 min';
      case 6:
        return '1 hora';
      case 11:
        return '2 horas';

      default:
        return 'Error - out of range';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FireCubit, FireState>(
      builder: ((context, state) {
        return Column(children: [
          PopupMenuButton<MapSourceParams>(
            icon: const TimeIcon(),
            iconSize: 55,
            initialValue: BlocProvider.of<FireCubit>(context).mapSourceParams,
            elevation: 16,
            onSelected: (mapSourceParams) {
              BlocProvider.of<FireCubit>(context)
                  .changeAmountOfRequests(mapSourceParams);
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<MapSourceParams>(
                  enabled: false,
                  child: Text(
                    'INPE',
                  ),
                ),
                PopupMenuItem<MapSourceParams>(
                  value: const MapSourceParams(
                    amount: 2,
                    mapSource: MapSource.inpe,
                  ),
                  child: Text(intToString(2)),
                ),
                PopupMenuItem<MapSourceParams>(
                  value: const MapSourceParams(
                    amount: 6,
                    mapSource: MapSource.inpe,
                  ),
                  child: Text(intToString(6)),
                ),
                PopupMenuItem<MapSourceParams>(
                  value: const MapSourceParams(
                    amount: 11,
                    mapSource: MapSource.inpe,
                  ),
                  child: Text(intToString(11)),
                ),
                const PopupMenuItem<MapSourceParams>(
                  enabled: false,
                  child: Text(
                    'NASA',
                  ),
                ),
                const PopupMenuItem<MapSourceParams>(
                  value: MapSourceParams(
                    amount: 1,
                    mapSource: MapSource.nasa,
                  ),
                  child: Text(
                    'Diário',
                  ),
                ),
              ];
            },
          ),
        ]);
      }),
    );
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
