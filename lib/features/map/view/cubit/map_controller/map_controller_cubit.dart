import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_controller_state.dart';

class MapControllerCubit extends Cubit<MapControllerState> {
  MapControllerCubit() : super(MapControllerInitial());

  late GoogleMapController mapController;

  void addActiveController(GoogleMapController activeController) {
    mapController = activeController;
    emit.call(MapControllerCompleted(activeController: activeController));
  }

  void moveCameraToPlace({required LatLng latlng, double? zoom}) {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: latlng,
        zoom: zoom ?? 12,
      ),
    ));
  }

  void moveLatLngPlace({required LatLng latlng}) {
    mapController.animateCamera(CameraUpdate.newLatLng(latlng));
  }
}
