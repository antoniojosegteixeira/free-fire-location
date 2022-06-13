import 'package:bloc/bloc.dart';
import 'package:free_fire_location/map/data/repositories/fire_repository.dart';
import 'package:free_fire_location/map/data/response_models/fire_page_response.dart';
import 'package:free_fire_location/map/view/pages/map_page.dart';
import 'package:meta/meta.dart';

part 'fire_state.dart';

class MapCubit extends Cubit<FireState> {
  final _mapRepository = FireRepository();
  MapCubit() : super(FireInitial());

  void getMapInfo() async {
    emit.call(FireLoading());
    try {
      final FirePageResponse fireInfo = await _mapRepository.getFireLocations();

      emit.call(FireSuccess(fireInfo: fireInfo));
    } catch (e) {
      print(e);
      emit.call(FireError());
    }
  }
}
