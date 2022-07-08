import 'package:bloc/bloc.dart';
import 'package:free_fire_location/map/data/repositories/notification_local_repository.dart';
import 'package:free_fire_location/map/data/response_models/notification_options.dart';
import 'package:meta/meta.dart';

part 'notification_range_state.dart';

class NotificationRangeCubit extends Cubit<NotificationRangeState> {
  final NotificationLocalRepository notificationLocalRepository =
      NotificationLocalRepository();
  NotificationOptionsResponse notificationOptionsResponse =
      NotificationOptionsResponse(range: 10);

  NotificationRangeCubit() : super(NotificationRangeInitial());

  void getCachedData() async {
    final NotificationOptionsResponse result =
        await notificationLocalRepository.getcachedNotificationOptions();
    notificationOptionsResponse = result;
    emit.call(NotificationRangeOn(options: notificationOptionsResponse));
  }

  void turnNotificationOn() {
    emit.call(NotificationRangeOn(options: notificationOptionsResponse));
  }

  void turnNotificationOff() {
    emit.call(NotificationRangeOff(options: notificationOptionsResponse));
  }

  void updateRangeValue(double newValue) async {
    notificationOptionsResponse = NotificationOptionsResponse(range: newValue);
    await notificationLocalRepository.cacheNotificationOptions(
        optionsToCache: notificationOptionsResponse);
    emit.call(NotificationRangeOn(options: notificationOptionsResponse));
  }
}
