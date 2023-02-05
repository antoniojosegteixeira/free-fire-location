import 'package:dartz/dartz.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/features/map/domain/entities/user_fire_entity.dart';

abstract class FirebaseRepository {
  Future<Either<Failure, List<UserFireEntity>>> getUserFires();

  Future<Either<Failure, bool>> postUserFire({
    required double latitude,
    required double longitude,
    required DateTime date,
  });
}
