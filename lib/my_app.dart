import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/map/view/cubit/fire/fire_cubit.dart';
import 'package:free_fire_location/map/view/pages/map.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fireCubit = FireCubit();

    return MaterialApp(
      title: 'FreeFire Locator',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => fireCubit..getFireInfo()),
        ],
        child: const MapPage(),
      ),
    );
  }
}
