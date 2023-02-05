import 'package:dartz/dartz.dart';
import 'package:free_fire_location/core/error/exceptions.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/features/map/data/datasources/firebase_datasource_impl.dart';
import 'package:free_fire_location/features/map/domain/entities/user_fire_entity.dart';
import 'package:free_fire_location/features/map/domain/repositories/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  FirebaseRepositoryImpl({required this.datasource});

  final FirebaseDatasourceImpl datasource;

  @override
  Future<Either<Failure, List<UserFireEntity>>> getUserFires() {
    return _getUserFires(() {
      return datasource.getUserFires();
    });
  }

  @override
  Future<Either<Failure, bool>> postUserFire({
    required double latitude,
    required double longitude,
    required DateTime date,
  }) {
    return _postUserFires(() {
      return datasource.postUserFire(
        latitude: latitude,
        longitude: longitude,
        date: date,
      );
    });
  }

  Future<Either<Failure, List<UserFireEntity>>> _getUserFires(
    Future<List<UserFireEntity>> Function() param0,
  ) async {
    try {
      final result = await param0();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, bool>> _postUserFires(
    Future<bool> Function() param0,
  ) async {
    try {
      final result = await param0();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
