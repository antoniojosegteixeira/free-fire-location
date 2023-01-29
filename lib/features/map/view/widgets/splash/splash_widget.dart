import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 2000),
            color: AppColors.darkBrown,
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
                  'FreeFire Locator',
                  style: TextStyle(
                      fontSize: 28,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold),
                )
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
