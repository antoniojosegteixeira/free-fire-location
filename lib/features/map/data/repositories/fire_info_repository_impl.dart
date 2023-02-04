import 'package:dartz/dartz.dart';
import 'package:free_fire_location/core/error/exceptions.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/features/map/data/datasources/fire_info_datasource_inpe.dart';
import 'package:free_fire_location/features/map/data/datasources/fire_info_datasource_nasa.dart';
import 'package:free_fire_location/features/map/domain/entities/fire_page_entity.dart';
import 'package:free_fire_location/features/map/domain/repositories/fire_info_repository.dart';

class FireInfoRepositoryImpl implements FireInfoRepository {
  FireInfoRepositoryImpl({
    required this.datasourceNasa,
    required this.datasourceInpe,
  });

  final FireInfoDatasourceNasa datasourceNasa;
  final FireInfoDatasourceInpe datasourceInpe;

  @override
  Future<Either<Failure, FirePageEntity>> getFireLocationsInpe({
    required int amount,
  }) {
    return _getFireLocations(() {
      return datasourceInpe.getFireLocations(amount: amount);
    });
  }

  @override
  Future<Either<Failure, FirePageEntity>> getFireLocationsNasa({
    int amount = 0,
  }) {
    return _getFireLocations(() {
      return datasourceNasa.getFireLocations();
    });
  }

  Future<Either<Failure, FirePageEntity>> _getFireLocations(
    Future<FirePageEntity> Function() param0,
  ) async {
    try {
      final result = await param0();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
