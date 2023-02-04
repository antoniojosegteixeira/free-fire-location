import 'package:dartz/dartz.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/features/map/domain/entities/fire_page_entity.dart';

abstract class FireInfoRepository {
  Future<Either<Failure, FirePageEntity>> getFireLocationsInpe({
    required int amount,
  });

  Future<Either<Failure, FirePageEntity>> getFireLocationsNasa({
    required int amount,
  });
}
