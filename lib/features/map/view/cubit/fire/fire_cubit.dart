import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/features/map/domain/entities/fire_info_entity.dart';
import 'package:free_fire_location/features/map/domain/usecases/get_fire_info_inpe_usecase.dart';
import 'package:free_fire_location/features/map/domain/usecases/get_fire_info_nasa_usecase.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'fire_state.dart';

class FireCubit extends Cubit<FireState> {
  final GetFireInfoInpeUsecase getFireInfoInpeUsecase;
  final GetFireInfoNasaUsecase getFireInfoNasaUsecase;

  late List<Marker> markers;
  int numberOfRequests = 2;
  late BitmapDescriptor markerImage;

  FireCubit({
    required this.getFireInfoInpeUsecase,
    required this.getFireInfoNasaUsecase,
  }) : super(FireInitial());

  Future<void> loadMarkers() async {
    markerImage = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(20, 20)),
      "assets/images/map_icon.png",
    );
  }

  void getFireInfo() async {
    emit.call(FireLoading());

    await loadMarkers();

    final fireInfo = await getFireInfoInpeUsecase.call(
      const GetFireInfoInpeParams(amount: 10),
    );

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

  void changeAmountOfRequests(int newAmount) {
    // Each request equals 10 minutes
    numberOfRequests = newAmount;
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
