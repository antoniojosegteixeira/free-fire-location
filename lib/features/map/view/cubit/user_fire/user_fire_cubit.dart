import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:free_fire_location/core/usecase/usecase.dart';
import 'package:free_fire_location/features/map/domain/usecases/get_user_fires_usecase.dart';
import 'package:free_fire_location/features/map/domain/usecases/post_user_fire_usecase.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'user_fire_state.dart';

class UserFireCubit extends Cubit<UserFireState> {
  UserFireCubit({
    required this.getUserFiresUsecase,
    required this.postUserFiresUsecase,
  }) : super(UserFireInitial());

  final GetUserFiresUsecase getUserFiresUsecase;
  final PostUserFireUsecase postUserFiresUsecase;

  Future<void> getUserFires() async {
    final response = await getUserFiresUsecase.call(NoParams());

    response.fold((l) {
      emit(UserFireGetFireFailure());
    }, (r) {
      emit(UserFireGetFireSuccess());
    });

    emit(UserFireInitial());
  }

  Future<void> addUserFire({required LatLng latLng}) async {
    final response = await postUserFiresUsecase.call(
      PostUserFireParams(
        latitude: latLng.latitude,
        longitude: latLng.longitude,
        date: DateTime.now(),
      ),
    );

    response.fold((l) {
      emit(UserFireAddFireFailure());
    }, (r) {
      emit(UserFireAddFireSuccess());
    });

    emit(UserFireInitial());
  }
}
