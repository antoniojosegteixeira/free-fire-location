import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:free_fire_location/consts/colors.dart' show AppColors;

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
  void initState() {
    Future.delayed(Duration(milliseconds: 2100), (){
     Navigator.pushNamed(context, '/map');   
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedContainer(duration: const Duration(milliseconds: 2000), 
      color: AppColors.heading, 
        child: Center(
          child: Column(children: [
            const SizedBox(height: 200,),
            Image.asset('assets/images/splash.png'),
            const SizedBox(height: 10,),
            const Text('FreeFire Locator', style: TextStyle(fontSize: 23),)
            
          ]),
        ),
      ),
    );
  }
}