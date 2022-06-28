import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'notification_range_state.dart';

class NotificationRangeCubit extends Cubit<NotificationRangeState> {
  //TODO: add cached value
  double alertRange = 1;
  NotificationRangeCubit() : super(NotificationRangeInitial());

  void turnNotificationOn() {
    emit.call(NotificationRangeOn(alertRange: alertRange));
  }

  void turnNotificationOff() {
    emit.call(NotificationRangeOff(alertRange: alertRange));
  }

  void updateRangeValue(double newValue) {
    alertRange = newValue;
    emit.call(NotificationRangeOn(alertRange: alertRange));
  }
}
