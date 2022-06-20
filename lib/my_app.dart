import 'package:flutter/material.dart';
import 'package:free_fire_location/map/view/cubit/fire/fire_cubit.dart';
import 'package:free_fire_location/map/view/pages/map.dart';
import 'package:free_fire_location/map/view/pages/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fireCubit = FireCubit();

<<<<<<< HEAD
    return MaterialApp(
      title: 'FreeFire Locator',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MapPage(),
=======
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => fireCubit..startRequesting()),
      ],
      child: MaterialApp(
        title: 'FreeFire Locator',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Scaffold(body: const SplashPage()),
          '/map': (context) => const MapPage(),
        },
      ),
>>>>>>> a3cb0508cf2a24d1c238fd72c64fd2af4ea7e7ff
    );
  }
}
