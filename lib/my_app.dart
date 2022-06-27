import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/map/view/cubit/fire/fire_cubit.dart';
import 'package:free_fire_location/map/view/cubit/notification/notification_cubit.dart';
import 'package:free_fire_location/map/view/cubit/options/options_cubit.dart';
import 'package:free_fire_location/map/view/pages/config_page.dart';
import 'package:free_fire_location/map/view/pages/map_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fireCubit = FireCubit();
    final optionsCubit = OptionsCubit();
    final notificationCubit = NotificationCubit();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => fireCubit..startRequesting()),
        BlocProvider(create: (_) => optionsCubit),
        BlocProvider(create: (_) => notificationCubit),
      ],
      child: MaterialApp(
        title: 'FreeFire Locator',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        initialRoute: '/map',
        routes: {
          '/map': (context) => const MapPage(),
        },
      ),
    );
  }
}
