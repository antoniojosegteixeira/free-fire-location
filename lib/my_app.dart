import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/features/map/view/cubit/fire/fire_cubit.dart';
import 'package:free_fire_location/features/map/view/cubit/location/location_cubit.dart';
import 'package:free_fire_location/features/map/view/cubit/map_controller/map_controller_cubit.dart';
import 'package:free_fire_location/features/map/view/cubit/options/options_cubit.dart';
import 'package:free_fire_location/features/map/view/cubit/places_search/places_search_cubit.dart';
import 'package:free_fire_location/features/map/view/cubit/weather_info/weather_info_cubit.dart';
import 'package:free_fire_location/features/map/view/pages/map_page.dart';
import 'package:get_it/get_it.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fireCubit = GetIt.I<FireCubit>();
    final weatherInfoCubit = GetIt.I<WeatherInfoCubit>();
    final locationCubit = GetIt.I<LocationCubit>();
    final placesSearchCubit = GetIt.I<PlacesSearchCubit>();
    final mapControllerCubit = GetIt.I<MapControllerCubit>();
    final optionsCubit = GetIt.I<OptionsCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => fireCubit..startRequesting()),
        BlocProvider(create: (_) => weatherInfoCubit),
        BlocProvider(create: (_) => locationCubit..setMapLocationState()),
        BlocProvider(create: (_) => placesSearchCubit),
        BlocProvider(create: (_) => mapControllerCubit),
        BlocProvider(create: (_) => optionsCubit),
      ],
      child: MaterialApp(
        title: 'FreeFire Locator',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/map',
        routes: {'/map': (context) => const MapPage()},
      ),
    );
  }
}
