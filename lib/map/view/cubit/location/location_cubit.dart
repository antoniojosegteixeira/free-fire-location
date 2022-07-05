import 'package:bloc/bloc.dart';
import 'package:free_fire_location/map/view/cubit/location/location_state.dart';
import 'package:free_fire_location/utils/location_service.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationDisabled());
  LocationService locationService = LocationService();

  Future<void> setMapLocationState() async {
    final location = await locationService.getLocation();
    if (locationService.isEnabled) {
      emit.call(LocationEnabled(position: location));
    } else {
      emit.call(LocationDisabled());
    }
  }
}
