import 'package:dartz/dartz.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/features/map/domain/entities/weather_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class WeatherInfoRepository {
  Future<Either<Failure, WeatherEntity>> getWeatherByCoordinates({
    required LatLng latlng,
  });
}
