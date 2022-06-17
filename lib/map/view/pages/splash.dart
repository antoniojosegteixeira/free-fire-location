import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return AnimatedContainer(duration: const Duration(milliseconds: 2000), child: Column(children: [
      SvgPicture.asset('assets/images/splash.svg'),
      const Text('FreeFire Locator')
    ]),);
  }

  
}