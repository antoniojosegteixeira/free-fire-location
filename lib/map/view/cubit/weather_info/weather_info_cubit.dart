import 'package:bloc/bloc.dart';
import 'package:free_fire_location/map/data/repositories/weather_repository.dart';
import 'package:free_fire_location/map/data/response_models/weather_response.dart';
import 'package:meta/meta.dart';

part 'weather_info_state.dart';

class WeatherInfoCubit extends Cubit<WeatherInfoState> {
  final _weatherRepository = WeatherRepository();
  WeatherInfoCubit() : super(WeatherInfoInitial());

  void getWeatherInfoByCoordinates({
    required double lat,
    required double lon,
  }) async {
    emit.call(WeatherInfoLoading());

    try {
      final WeatherResponse weatherResponse =
          await _weatherRepository.getWeatherByCoordinates(lat: lat, lon: lon);

      emit.call(WeatherInfoLoaded(weatherResponse: weatherResponse));
    } catch (err) {
      emit.call(WeatherInfoError());
    }
  }
}
