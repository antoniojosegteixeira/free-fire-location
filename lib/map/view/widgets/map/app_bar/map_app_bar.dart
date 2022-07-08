import 'package:flutter/material.dart';
import 'package:free_fire_location/map/view/widgets/map/controls/menu_button.dart';
import 'package:free_fire_location/map/view/widgets/map/input/search_input.dart';

class MapAppBar extends StatelessWidget {
  const MapAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MenuButton(),
        Expanded(child: SearchInput()),
        const SizedBox(
          width: 25,
          height: 60,
        ),
      ],
    );
  }
}
