import 'package:flutter/material.dart';
import 'package:free_fire_location/map/view/widgets/splash.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.of(context).pushReplacementNamed('/map');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SplashWidget();
  }
}
