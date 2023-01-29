import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'options_state.dart';

class OptionsCubit extends Cubit<MapType> {
  MapType mapType = MapType.normal;
  OptionsCubit() : super(MapType.normal);

  void changeMapType(MapType type) {
    mapType = type;

    emit.call(mapType);
  }
}
