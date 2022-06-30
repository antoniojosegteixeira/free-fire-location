import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:free_fire_location/map/data/repositories/fire_repository.dart';
import 'package:free_fire_location/map/models/fire_page.dart';
import 'package:free_fire_location/utils/generate_markers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'fire_state.dart';

class FireCubit extends Cubit<FireState> {
  final _mapRepository = FireRepository();
  late List<Marker> markers;
  int numberOfRequests = 2;
  FireCubit() : super(FireInitial());

  void getFireInfo() async {
    emit.call(FireLoading());

    final customMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(20, 20)),
      "assets/images/splash.png",
    );

    try {
      final FirePage fireInfo =
          await _mapRepository.getFireLocations(numberOfRequests);

      List<Marker> generatedMarkers = GenerateMarkers.generate(
        customMarkerImage: customMarker,
        coordinatesList: fireInfo.coordinatesList,
      );

      markers = generatedMarkers;
      //print(fireInfo.coordinatesList);

      emit.call(FireSuccess(markers: markers));
    } catch (err) {
      emit.call(FireError(error: err as Error));
    }
  }

  void updateEveryTenMinutes() {
    Timer.periodic(const Duration(minutes: 1), (timer) {
      DateTime currentTime = DateTime.now();

      if (currentTime.minute.toString().padLeft(2, '0').substring(1) == '0') {
        getFireInfo();
      }
    });
  }

  void changeAmountOfRequests(int newAmount) {
    // Each request equals 10 minutes
    numberOfRequests = newAmount;
    getFireInfo();
  }

  Future showSplash() {
    return Future.delayed(const Duration(seconds: 3), () {});
  }

  void startRequesting() async {
    await showSplash();
    getFireInfo();
    updateEveryTenMinutes();
  }
}
