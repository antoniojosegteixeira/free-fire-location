import 'package:bloc/bloc.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:free_fire_location/core/usecase/usecase.dart';
import 'package:free_fire_location/features/map/domain/entities/user_fire_entity.dart';
import 'package:free_fire_location/features/map/domain/usecases/get_user_fires_usecase.dart';
import 'package:free_fire_location/features/map/domain/usecases/post_user_fire_usecase.dart';
import 'package:free_fire_location/features/map/view/cubit/weather_info/weather_info_cubit.dart';
import 'package:free_fire_location/utils/generate_markers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'user_fire_state.dart';

class UserFireCubit extends Cubit<UserFireState> {
  UserFireCubit({
    required this.getUserFiresUsecase,
    required this.postUserFiresUsecase,
    required this.weatherInfoCubit,
  }) : super(UserFireInitial());

  final GetUserFiresUsecase getUserFiresUsecase;
  final PostUserFireUsecase postUserFiresUsecase;
  final WeatherInfoCubit weatherInfoCubit;
  List<Marker> userMarkers = [];

  Future<BitmapDescriptor> _loadMarkers() async {
    final userMarkerImage = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(20, 20)),
      "assets/images/user_map_icon.png",
    );

    return userMarkerImage;
  }

  Future<void> getUserFires() async {
    final icon = await _loadMarkers();
    final response = await getUserFiresUsecase.call(NoParams());

    response.fold((l) {
      emit(UserFireGetFireFailure());
    }, (r) {
      final markers = generateMarkers(
        customUserMarkerImage: icon,
        coordinatesList: r,
        customInfoWindowController: weatherInfoCubit.customInfoWindowController,
      );

      emit(UserFireGetFireSuccess(userFireList: r, markers: markers));
    });
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
      getUserFires();
    });
  }

  // Setting markers

  List<Marker> generateMarkers({
    required BitmapDescriptor customUserMarkerImage,
    required List<UserFireEntity> coordinatesList,
    required CustomInfoWindowController customInfoWindowController,
  }) {
    List<Marker> generatedMarkers = GenerateMarkers.generateUserMarker(
        customUserMarkerImage: customUserMarkerImage,
        coordinatesList: coordinatesList,
        customInfoWindowController: weatherInfoCubit.customInfoWindowController,
        callback: (LatLng latLng) {
          weatherInfoCubit.getWeatherInfoByCoordinates(latLng: latLng);
        });

    userMarkers = generatedMarkers;

    return generatedMarkers;
  }
}
