import 'package:bloc/bloc.dart';
import 'package:free_fire_location/map/data/repositories/fire_repository.dart';
import 'package:free_fire_location/map/data/response_models/fire_page_response.dart';
import 'package:free_fire_location/map/view/pages/map_page.dart';
import 'package:meta/meta.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final _mapRepository = MapRepository();
  MapCubit() : super(MapInitial());

  void getMapInfo() async {
    emit.call(MapLoading());
    try {
      final MapPageResponse fireInfo = await _mapRepository.getFireLocations();
      final MapPageResponse mapPage = MapPageResponse(
        coordinatesList: fireInfo.coordinatesList,
      );

      print(mapPage.coordinatesList);
      emit.call(MapSuccess(fireInfo: mapPage));
    } catch (e) {
      print(e);
      emit.call(MapError());
    }
  }
}
