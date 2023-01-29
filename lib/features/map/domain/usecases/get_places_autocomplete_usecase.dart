import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/core/usecase/usecase.dart';
import 'package:free_fire_location/features/map/data/repositories/places_repository_impl.dart';
import 'package:free_fire_location/features/map/domain/entities/places_autocomplete_entity.dart';

class GetPlacesAutocompleteUsecase
    implements
        UseCase<List<PlacesAutocompleteEntity>, GetPlacesAutocompleteParams> {
  GetPlacesAutocompleteUsecase({required this.repository});
  final PlacesRepositoryImpl repository;

  @override
  Future<Either<Failure, List<PlacesAutocompleteEntity>>> call(
    GetPlacesAutocompleteParams params,
  ) async {
    return repository.getAutocompleteInfo(
      input: params.input,
    );
  }
}

class GetPlacesAutocompleteParams extends Equatable {
  const GetPlacesAutocompleteParams({
    required this.input,
  });
  final String input;

  @override
  List<Object> get props => [
        input,
      ];
}
