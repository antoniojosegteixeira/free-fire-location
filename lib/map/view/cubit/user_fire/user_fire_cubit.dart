import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'user_fire_state.dart';

class UserFireCubit extends Cubit<UserFireState> {
  UserFireCubit() : super(UserFireClosed());

  void openModal({required LatLng coordinates}) {
    emit.call(UserFireOpen(
      coordinates: coordinates,
    ));
  }

  void closeModal() {
    emit.call(UserFireClosed());
  }
}
