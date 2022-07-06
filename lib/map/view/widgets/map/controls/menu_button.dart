import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: const Icon(
        Icons.menu,
        size: 32,
        color: AppColors.delete,
      ),
    );
  }
}
