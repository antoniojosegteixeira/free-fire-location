import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/features/map/view/cubit/location/location_cubit.dart';
import 'package:free_fire_location/features/map/view/cubit/location/location_state.dart';
import 'package:free_fire_location/features/map/view/cubit/map_controller/map_controller_cubit.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationButton extends StatefulWidget {
  const LocationButton({Key? key}) : super(key: key);

  @override
  State<LocationButton> createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapControllerCubit, MapControllerState>(
      builder: ((context, state) {
        if (state is MapControllerCompleted) {
          return BlocBuilder<LocationCubit, LocationState>(
              builder: ((locationContext, locationState) {
            if (locationState is LocationEnabled) {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                    elevation: 0,
                  ),
                  onPressed: () {
                    context.read<MapControllerCubit>().moveCameraToPlace(
                        latlng: LatLng(locationState.position.latitude,
                            locationState.position.longitude));
                  },
                  child: const Icon(
                    Icons.location_on,
                    size: 32,
                  ));
            }

            return const UnactiveLocationButton();
          }));
        } else {
          return const UnactiveLocationButton();
        }
      }),
    );
  }
}

class UnactiveLocationButton extends StatelessWidget {
  const UnactiveLocationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(12),
        elevation: 0,
      ),
      onPressed: () {},
      child: const Icon(
        Icons.location_on,
        size: 32,
      ),
    );
  }
}
