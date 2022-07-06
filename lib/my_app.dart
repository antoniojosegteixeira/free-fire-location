import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/map/view/cubit/fire/fire_cubit.dart';
import 'package:free_fire_location/map/view/cubit/location/location_cubit.dart';
import 'package:free_fire_location/map/view/cubit/notification_range/notification_range_cubit.dart';
import 'package:free_fire_location/map/view/cubit/options/options_cubit.dart';
import 'package:free_fire_location/map/view/cubit/weather_info/weather_info_cubit.dart';
import 'package:free_fire_location/map/view/cubit/search/search_cubit.dart';
import 'package:free_fire_location/map/view/pages/map_page.dart';
import 'package:free_fire_location/map/view/pages/test_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fireCubit = FireCubit();
    final optionsCubit = OptionsCubit();
    final notificationRangeCubit = NotificationRangeCubit();
    final weatherInfoCubit = WeatherInfoCubit();
    final locationCubit = LocationCubit();
    final searchCubit = SearchCubit();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => fireCubit..startRequesting()),
        BlocProvider(create: (_) => optionsCubit),
        BlocProvider(create: (_) => notificationRangeCubit),
        BlocProvider(create: (_) => weatherInfoCubit),
        BlocProvider(create: (_) => locationCubit..setMapLocationState()),
        BlocProvider(create: (_) => searchCubit),
      ],
      child: MaterialApp(
        title: 'FreeFire Locator',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/map': (context) => const MapPage(),
          '/': (context) => Teste(),
        },
      ),
    );
  }
}
