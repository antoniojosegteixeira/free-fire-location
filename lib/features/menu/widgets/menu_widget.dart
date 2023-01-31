import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/features/map/view/pages/about_page.dart';
import 'package:free_fire_location/features/menu/widgets/firefighter_button.dart';
import 'package:free_fire_location/features/menu/widgets/menu_field.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.darkBrown,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(20)),
            const SizedBox(height: 5),
            SizedBox(
                width: 100,
                height: 100,
                child: Image.asset('assets/images/splash.png')),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'FreeFire Locator',
                style: TextStyle(
                    fontSize: 20,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 35),
            const MenuField(description: 'Sobre', nav: AboutPage()),
            const Spacer(),
            const FirefighterButton(),
            const Padding(padding: EdgeInsets.only(bottom: 20))
          ],
        ),
      ),
    );
  }
}
