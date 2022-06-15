import 'package:bloc/bloc.dart';
import 'package:free_fire_location/map/data/repositories/fire_repository.dart';
import 'package:free_fire_location/map/data/response_models/fire_page_response.dart';
import 'package:free_fire_location/map/models/fire_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'fire_state.dart';

class FireCubit extends Cubit<FireState> {
  final _mapRepository = FireRepository();
  FireCubit() : super(FireInitial());

  void getFireInfo() async {
    emit.call(FireLoading());
    try {
      final FirePage fireInfo = await _mapRepository.getFireLocations();

      List<Marker> markers = fireInfo.coordinatesList.map((item) {
        return Marker(
          markerId: MarkerId('${item.latitude}${item.longitude}${item.date}'),
          position: LatLng(item.latitude, item.longitude),
          infoWindow: InfoWindow(title: '${item.satelliteName} - ${item.date}'),
        );
      }).toList();

      emit.call(FireSuccess(markers: markers));
    } catch (e) {
      emit.call(FireError());
    }
  }
}
