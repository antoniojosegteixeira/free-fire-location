import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/features/map/view/cubit/weather_info/weather_info_cubit.dart';
import 'package:free_fire_location/features/map/view/widgets/map/map_info_popup/popup_content.dart';

class MapInfoPopup extends StatelessWidget {
  const MapInfoPopup({
    Key? key,
    this.isFromUser,
  }) : super(key: key);

  final bool? isFromUser;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherInfoCubit, WeatherInfoState>(
      builder: ((context, state) {
        if (state is WeatherInfoLoading) {
          return const Card(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is WeatherInfoLoaded) {
          return PopUpContent(
            weather: state.weatherResponse,
            isFromUser: isFromUser,
          );
        } else if (state is WeatherInfoError) {
          return Card(
            child: Column(
              children: const [Text('Erro ao buscar informações.')],
            ),
          );
        }

        return Container();
      }),
    );
  }
}
