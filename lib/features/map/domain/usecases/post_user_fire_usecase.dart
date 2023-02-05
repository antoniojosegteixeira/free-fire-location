import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/core/usecase/usecase.dart';
import 'package:free_fire_location/features/map/data/repositories/firebase_repository_impl.dart';

class PostUserFireUsecase implements UseCase<bool, PostUserFireParams> {
  PostUserFireUsecase({required this.repository});
  final FirebaseRepositoryImpl repository;

  @override
  Future<Either<Failure, bool>> call(
    PostUserFireParams params,
  ) async {
    return repository.postUserFire(
      latitude: params.latitude,
      longitude: params.longitude,
      date: params.date,
    );
  }
}

class PostUserFireParams extends Equatable {
  const PostUserFireParams({
    required this.latitude,
    required this.longitude,
    required this.date,
  });
  final double latitude;
  final double longitude;
  final DateTime date;

  @override
  List<Object> get props => [
        latitude,
        longitude,
        date,
      ];
}
