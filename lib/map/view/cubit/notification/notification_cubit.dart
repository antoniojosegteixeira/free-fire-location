import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  //TODO: add cached value
  double alertRange = 1;
  NotificationCubit() : super(NotificationInitial());

  void turnNotificationOn() {
    emit.call(NotificationOn(alertRange: alertRange));
  }

  void turnNotificationOff() {
    emit.call(NotificationOff(alertRange: alertRange));
  }

  void updateRangeValue(double newValue) {
    alertRange = newValue;
    emit.call(NotificationOn(alertRange: alertRange));
  }
}
