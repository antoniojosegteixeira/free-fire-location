import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: AppColors.primary,
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
