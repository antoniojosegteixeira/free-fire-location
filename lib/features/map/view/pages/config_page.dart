import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/features/map/view/widgets/location/notification_permission_widget.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
            padding: EdgeInsets.only(left: 60), child: Text('CONFIGURAÇÕES')),
        backgroundColor: AppColors.darkBrown,
        elevation: 0,
      ),
      backgroundColor: AppColors.darkBrown,
      body: SafeArea(
        child: Column(
          children: const [
            SizedBox(height: 50),
            NotificationPermissionWidget(),
            SizedBox(height: 20),
            SizedBox(height: 45),
          ],
        ),
      ),
    );
  }
}
