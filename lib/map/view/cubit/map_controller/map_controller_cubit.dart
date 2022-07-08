import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'map_controller_state.dart';

class MapControllerCubit extends Cubit<MapControllerState> {
  MapControllerCubit() : super(MapControllerInitial());

  void addActiveController(GoogleMapController activeController) {
    emit.call(MapControllerCompleted(activeController: activeController));
  }
}
