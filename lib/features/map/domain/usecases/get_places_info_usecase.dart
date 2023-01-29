import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/core/usecase/usecase.dart';
import 'package:free_fire_location/features/map/data/repositories/places_repository_impl.dart';
import 'package:free_fire_location/features/map/domain/entities/places_info_entity.dart';

class GetPlacesInfoUsecase
    implements UseCase<PlacesInfoEntity, GetPlacesInfoParams> {
  GetPlacesInfoUsecase({required this.repository});
  final PlacesRepositoryImpl repository;

  @override
  Future<Either<Failure, PlacesInfoEntity>> call(
    GetPlacesInfoParams params,
  ) async {
    return repository.getPlacesInfo(
      placeId: params.placeId,
    );
  }
}

class GetPlacesInfoParams extends Equatable {
  const GetPlacesInfoParams({
    required this.placeId,
  });
  final String placeId;

  @override
  List<Object> get props => [
        placeId,
      ];
}
