import 'package:flutter/material.dart';
import 'package:free_fire_location/map/view/widgets/splash.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 2000),
        color: AppColors.hufflepuffDarkBrown,
        child: Center(
          child: Column(children: [
            const SizedBox(
              height: 200,
            ),
            Image.asset('assets/images/splash.png'),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'FreeFire Location',
              style: TextStyle(
                  fontSize: 28,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold),
            )
          ]),
        ),
      ),
    );
  }
}
