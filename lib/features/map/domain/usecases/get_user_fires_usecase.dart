import 'package:dartz/dartz.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/core/usecase/usecase.dart';
import 'package:free_fire_location/features/map/data/repositories/firebase_repository_impl.dart';
import 'package:free_fire_location/features/map/domain/entities/user_fire_entity.dart';

class GetUserFiresUsecase implements UseCase<List<UserFireEntity>, NoParams> {
  GetUserFiresUsecase({required this.repository});
  final FirebaseRepositoryImpl repository;

  @override
  Future<Either<Failure, List<UserFireEntity>>> call(
    NoParams params,
  ) async {
    return repository.getUserFires();
  }
}
