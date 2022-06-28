import 'package:bloc/bloc.dart';
import 'package:free_fire_location/map/view/cubit/notification_permission/notification_permission_state.dart';

class NotificationPermissionCubit extends Cubit<NotificationPermissionState> {
  late bool isActivated;
  NotificationPermissionCubit() : super(NotificationPermissionOff());

  void updatePermissionValue(bool newValue) {
    isActivated = newValue;
    if (isActivated) {
      emit.call(NotificationPermissionOn(isActivated: isActivated));
    }
    if (!isActivated) {
      emit.call(NotificationPermissionOff());
    }
  }
}
