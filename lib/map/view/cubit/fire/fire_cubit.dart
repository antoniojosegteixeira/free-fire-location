import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:free_fire_location/map/data/repositories/fire_repository.dart';
import 'package:free_fire_location/map/models/fire_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:cron/cron.dart';

part 'fire_state.dart';

class FireCubit extends Cubit<FireState> {
  final _mapRepository = FireRepository();
  final _cron = Cron();
  late final List<Marker> markers;
  FireCubit() : super(FireInitial());

  void getFireInfo() async {
    final customMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(20, 20)),
      "assets/images/splash.png",
    );

    try {
      final FirePage fireInfo = await _mapRepository.getFireLocations();

      List<Marker> markers = fireInfo.coordinatesList.map((item) {
        return Marker(
            markerId: MarkerId('${item.latitude}${item.longitude}${item.date}'),
            position: LatLng(item.latitude, item.longitude),
            infoWindow:
                InfoWindow(title: '${item.satelliteName} - ${item.date}'),
            icon: customMarker);
      }).toList();

      emit.call(FireSuccess(markers: markers));
    } catch (e) {
      emit.call(FireError());
    }
  }

  void startRequesting() {
    getFireInfo();
    _cron.schedule(Schedule.parse('*/10 * * * *'), () async {
      getFireInfo();
    });
  }
}
