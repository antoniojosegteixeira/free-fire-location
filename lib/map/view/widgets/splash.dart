import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:free_fire_location/consts/colors.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  final Color _backgroundColor = const Color.fromRGBO(88, 86, 102, 1);
  final String _image = 'assets/images/splash.png';
  late double _width = 1;
  late double _height = 1;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 10), ((){
      setState(() {
        _width = 400;
        _height = 400;
      });
    } ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: _backgroundColor, 
        ),
        AnimatedContainer(duration: const Duration(milliseconds: 2500),
          curve: Curves.bounceOut,
          width: _width,
          height: _height,
          child: Image.asset(_image),    
          ),
      ],
    );
  }
}