import 'package:dartz/dartz.dart';
import 'package:free_fire_location/core/error/exceptions.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/features/map/data/datasources/weather_info_datasource.dart';
import 'package:free_fire_location/features/map/domain/entities/weather_entity.dart';
import 'package:free_fire_location/features/map/domain/repositories/weather_info_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WeatherInfoRepositoryImpl implements WeatherInfoRepository {
  WeatherInfoRepositoryImpl({
    required this.datasource,
  });

  final WeatherInfoDatasource datasource;

  @override
  Future<Either<Failure, WeatherEntity>> getWeatherByCoordinates({
    required LatLng latlng,
  }) {
    return _getWeatherByCoordinates(() {
      return datasource.getWeatherByCoordinates(latLng: latlng);
    });
  }

  Future<Either<Failure, WeatherEntity>> _getWeatherByCoordinates(
    Future<WeatherEntity> Function() param0,
  ) async {
    try {
      final result = await param0();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
