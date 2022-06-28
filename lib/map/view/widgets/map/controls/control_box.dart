import 'package:flutter/material.dart';
import 'package:free_fire_location/map/view/widgets/map/controls/location_button.dart';
import 'package:free_fire_location/map/view/widgets/map/controls/map_type_button.dart';

class ControlBox extends StatelessWidget {
  const ControlBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 80, 4, 4),
            child: MapTypeButton(),
          ),
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: LocationButton(),
          ),
        ],
      ),
    );
  }
}
