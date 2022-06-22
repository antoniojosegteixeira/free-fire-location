import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';

class MapTypeButton extends StatelessWidget {
  const MapTypeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: AppColors.primary,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15),
        ),
        onPressed: () {},
        child: const Icon(
          Icons.map,
          size: 32,
        ));
  }
}
