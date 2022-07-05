import 'package:bloc/bloc.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:free_fire_location/map/data/repositories/weather_repository.dart';
import 'package:free_fire_location/map/data/response_models/weather_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'weather_info_state.dart';

class WeatherInfoCubit extends Cubit<WeatherInfoState> {
  final _weatherRepository = WeatherRepository();
  final CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  WeatherInfoCubit() : super(WeatherInfoLoading());

  void getWeatherInfoByCoordinates({
    required LatLng latLng,
  }) async {
    emit.call(WeatherInfoLoading());

    try {
      final WeatherResponse weatherResponse =
          await _weatherRepository.getWeatherByCoordinates(latLng);

      emit.call(WeatherInfoLoaded(weatherResponse: weatherResponse));
    } catch (err) {
      emit.call(WeatherInfoError(error: err as Error));
    }
  }

  void setcustomInfoWindowController(GoogleMapController controller) {
    customInfoWindowController.googleMapController = controller;
  }
}
