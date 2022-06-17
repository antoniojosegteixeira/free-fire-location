import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  void updateScreen(){
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(duration: const Duration(milliseconds: 2000), child: Center(
      child: Column(children: [
        Image.asset('assets/images/splash.png'),
        const Text('FreeFire Locator')
      ]),
    ),);
  }
}