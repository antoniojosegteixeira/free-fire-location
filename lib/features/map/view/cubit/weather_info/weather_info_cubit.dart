import 'package:meta/meta.dart';
import 'package:free_fire_location/features/map/domain/entities/weather_entity.dart';
import 'package:free_fire_location/features/map/domain/usecases/get_weather_info_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'weather_info_state.dart';

class WeatherInfoCubit extends Cubit<WeatherInfoState> {
  final GetWeatherInfoUsecase getWeatherInfoUsecase;
  final CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  WeatherInfoCubit({
    required this.getWeatherInfoUsecase,
  }) : super(WeatherInfoLoading());

  void getWeatherInfoByCoordinates({
    required LatLng latLng,
  }) async {
    emit.call(WeatherInfoLoading());

    final weatherResponse =
        await getWeatherInfoUsecase.call(GetWeatherInfoParams(latlng: latLng));

    weatherResponse.fold((l) {
      emit.call(WeatherInfoError());
    }, (r) {
      emit.call(WeatherInfoLoaded(weatherResponse: r));
    });
  }

  void setcustomInfoWindowController(GoogleMapController controller) {
    customInfoWindowController.googleMapController = controller;
  }
}
