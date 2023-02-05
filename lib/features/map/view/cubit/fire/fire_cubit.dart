import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/features/map/domain/entities/fire_info_entity.dart';
import 'package:free_fire_location/features/map/domain/entities/fire_page_entity.dart';
import 'package:free_fire_location/features/map/domain/usecases/get_fire_info_inpe_usecase.dart';
import 'package:free_fire_location/features/map/domain/usecases/get_fire_info_nasa_usecase.dart';
import 'package:free_fire_location/features/map/view/cubit/weather_info/weather_info_cubit.dart';
import 'package:free_fire_location/utils/generate_markers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'fire_state.dart';

class FireCubit extends Cubit<FireState> {
  final GetFireInfoInpeUsecase getFireInfoInpeUsecase;
  final GetFireInfoNasaUsecase getFireInfoNasaUsecase;

  late List<Marker> markers;
  MapSourceParams mapSourceParams = const MapSourceParams(
    amount: 2,
    mapSource: MapSource.inpe,
  );
  late BitmapDescriptor markerImage;
  final WeatherInfoCubit weatherInfoCubit;

  FireCubit({
    required this.getFireInfoInpeUsecase,
    required this.getFireInfoNasaUsecase,
    required this.weatherInfoCubit,
  }) : super(FireInitial());

  Future<void> loadMarkers() async {
    markerImage = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(20, 20)),
      "assets/images/map_icon.png",
    );
  }

  List<Marker> generateMarkers(
      {required BitmapDescriptor customMarkerImage,
      required List<FireInfoEntity> coordinatesList,
      required}) {
    List<Marker> generatedMarkers = GenerateMarkers.generateMarkers(
      customMarkerImage: markerImage,
      coordinatesList: coordinatesList,
      customInfoWindowController: weatherInfoCubit.customInfoWindowController,
      callback: (LatLng latLng) {
        weatherInfoCubit.getWeatherInfoByCoordinates(latLng: latLng);
      },
    );
    return generatedMarkers;
  }

  void getFireInfo() async {
    emit.call(FireLoading());

    await loadMarkers();

    late Either<Failure, FirePageEntity> fireInfo;

    if (mapSourceParams.mapSource == MapSource.inpe) {
      fireInfo = await getFireInfoInpeUsecase.call(
        GetFireInfoInpeParams(amount: mapSourceParams.amount),
      );
    } else if (mapSourceParams.mapSource == MapSource.nasa) {
      fireInfo = await getFireInfoNasaUsecase.call(
        const GetFireInfoNasaParams(amount: 1),
      );
    }

    fireInfo.fold((l) {
      emit.call(FireError(error: l as Error));
    }, (r) {
      emit.call(FireSuccess(
        markerImage: markerImage,
        coordinatesList: r.coordinatesList,
      ));
    });
  }

  void updateEveryTenMinutes() {
    Timer.periodic(const Duration(minutes: 1), (timer) {
      DateTime currentTime = DateTime.now();

      if (currentTime.minute.toString().padLeft(2, '0').substring(1) == '0') {
        getFireInfo();
      }
    });
  }

  void changeAmountOfRequests(MapSourceParams newMapSourceParams) {
    // Each request equals 10 minutes
    mapSourceParams = newMapSourceParams;

    getFireInfo();
  }

  Future showSplash() {
    return Future.delayed(const Duration(seconds: 3), () {});
  }

  void startRequesting() async {
    await loadMarkers();
    await showSplash();
    getFireInfo();
    updateEveryTenMinutes();
  }
}

class MapSourceParams {
  final int amount;
  final MapSource mapSource;

  const MapSourceParams({
    required this.amount,
    required this.mapSource,
  });
}

enum MapSource {
  inpe,
  nasa,
}
