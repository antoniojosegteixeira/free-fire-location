import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/core/usecase/usecase.dart';
import 'package:free_fire_location/features/map/domain/entities/weather_entity.dart';
import 'package:free_fire_location/features/map/domain/repositories/weather_info_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetWeatherInfoUsecase
    implements UseCase<WeatherEntity, GetWeatherInfoParams> {
  GetWeatherInfoUsecase({required this.repository});
  final WeatherInfoRepository repository;

  @override
  Future<Either<Failure, WeatherEntity>> call(
    GetWeatherInfoParams params,
  ) async {
    return repository.getWeatherByCoordinates(
      latlng: params.latlng,
    );
  }
}

class GetWeatherInfoParams extends Equatable {
  const GetWeatherInfoParams({
    required this.latlng,
  });
  final LatLng latlng;

  @override
  List<Object> get props => [latlng];
}
