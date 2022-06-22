import 'package:flutter/material.dart';
import 'package:free_fire_location/map/view/widgets/controls/menu_button.dart';
import 'package:free_fire_location/map/view/widgets/input/search_input.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        SizedBox(
          width: 70,
          height: 60,
          child: MenuButton(),
        ),
        Expanded(child: SearchInput()),
        SizedBox(
          width: 25,
          height: 60,
        ),
      ],
    );
  }
}
