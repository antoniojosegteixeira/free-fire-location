import 'package:dartz/dartz.dart';
import 'package:free_fire_location/core/error/exceptions.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/features/map/data/datasources/places_autocomplete_datasource.dart';
import 'package:free_fire_location/features/map/data/datasources/places_info_datasource.dart';
import 'package:free_fire_location/features/map/data/models/places_info_model.dart';
import 'package:free_fire_location/features/map/domain/entities/places_autocomplete_entity.dart';
import 'package:free_fire_location/features/map/domain/entities/places_info_entity.dart';
import 'package:free_fire_location/features/map/domain/repositories/places_repository.dart';

class PlacesRepositoryImpl implements PlacesRepository {
  PlacesRepositoryImpl({
    required this.datasourceInfo,
    required this.datasourceAutocomplete,
  });

  final PlacesInfoDatasource datasourceInfo;
  final PlacesAutocompleteDatasource datasourceAutocomplete;

  @override
  Future<Either<Failure, PlacesInfoEntity>> getPlacesInfo({
    required String placeId,
  }) {
    return _getPlacesInfo(() {
      return datasourceInfo.getPlacesInfo(placeId: placeId);
    });
  }

  @override
  Future<Either<Failure, List<PlacesAutocompleteEntity>>> getAutocompleteInfo({
    required String input,
  }) {
    return _getAutocompleteInfo(() {
      return datasourceAutocomplete.getPlacesAutocomplete(input: input);
    });
  }

  Future<Either<Failure, PlacesInfoModel>> _getPlacesInfo(
    Future<PlacesInfoModel> Function() param0,
  ) async {
    try {
      final result = await param0();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<PlacesAutocompleteEntity>>> _getAutocompleteInfo(
    Future<List<PlacesAutocompleteEntity>> Function() param0,
  ) async {
    try {
      final result = await param0();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
