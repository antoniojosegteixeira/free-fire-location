import 'package:dartz/dartz.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/features/map/domain/entities/places_autocomplete_entity.dart';
import 'package:free_fire_location/features/map/domain/entities/places_info_entity.dart';

abstract class PlacesRepository {
  Future<Either<Failure, PlacesInfoEntity>> getPlacesInfo({
    required String placeId,
  });

  Future<Either<Failure, List<PlacesAutocompleteEntity>>> getAutocompleteInfo({
    required String input,
  });
}
