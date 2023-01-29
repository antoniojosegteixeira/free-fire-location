part of 'weather_info_cubit.dart';

@immutable
abstract class WeatherInfoState {}

class WeatherInfoLoading extends WeatherInfoState {}

class WeatherInfoLoaded extends WeatherInfoState {
  final WeatherEntity weatherResponse;
  WeatherInfoLoaded({required this.weatherResponse});
}

class WeatherInfoError extends WeatherInfoState {}
