part of 'weather_info_cubit.dart';

@immutable
abstract class WeatherInfoState {}

class WeatherInfoLoading extends WeatherInfoState {}

class WeatherInfoLoaded extends WeatherInfoState {
  final WeatherResponse weatherResponse;
  WeatherInfoLoaded({required this.weatherResponse});
}

class WeatherInfoError extends WeatherInfoState {
  final Error error;
  WeatherInfoError({required this.error});
}
