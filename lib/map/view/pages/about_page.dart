import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBrown,
      appBar: AppBar(
        backgroundColor: AppColors.darkBrown,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 90),
          child: Text('SOBRE'),
        ),
      ),
      body: const Center(
          child: Text(
        'Made with ❤️ by Antônio and Rodolfo',
        style: TextStyle(color: AppColors.white, fontSize: 16),
      )),
    );
  }
}
