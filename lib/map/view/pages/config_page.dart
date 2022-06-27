import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/map/view/widgets/controls/notification_slider.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkBrown,
          elevation: 0,
        ),
        backgroundColor: AppColors.darkBrown,
        body: SafeArea(
            child: Container(
          child: Column(children: const [
            NotificationSlider(),
          ]),
        )));
  }
}
