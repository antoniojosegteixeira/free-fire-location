import 'package:flutter/material.dart';
import 'package:free_fire_location/map/view/widgets/map/controls/location_button.dart';
import 'package:free_fire_location/map/view/widgets/map/controls/map_type_button.dart';
import 'package:free_fire_location/map/view/widgets/map/controls/time_button.dart';

class ControlBox extends StatelessWidget {
  const ControlBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(4, 80, 4, 4),
            child: MapTypeButton(),
          ),
          Padding(
            padding: EdgeInsets.all(4.0),
            child: LocationButton(),
          ),
          Padding(
            padding: EdgeInsets.all(4.0),
            child: TimeButton(),
          ),
        ],
      ),
    );
  }
}
