import 'package:free_fire_location/map/data/repositories/fire_repository.dart';
import 'package:free_fire_location/map/data/repositories/notification_local_repository.dart';
import 'package:free_fire_location/map/data/response_models/notification_options.dart';
import 'package:free_fire_location/map/models/fire_page.dart';
import 'package:free_fire_location/notifications/notifications.dart';
import 'package:free_fire_location/notifications/utils/coordinates_range_converter.dart';
import 'package:free_fire_location/utils/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CheckNearbyFires {
  Future<double> _getRange() async {
    NotificationOptionsResponse options =
        await NotificationLocalRepository().getcachedNotificationOptions();

    return options.range;
  }

  Future<LatLng> _getLocation() async {
    LocationService locationService = LocationService();
    final Position location = await locationService.getLocation();
    return LatLng(location.latitude, location.longitude);
  }

  Future<int> _checkFires() async {
    FireRepository repository = FireRepository();
    int numberOfFiresNearby = 0;
    double range =
        CoordinatesRangeConverter.coordinatesToRange(await _getRange());
    try {
      final FirePage fireInfo = await repository.getFireLocations(2);
      final LatLng userPosition = await _getLocation();

      for (int i = 0; i < fireInfo.coordinatesList.length; i++) {
        final item = fireInfo.coordinatesList[i];
        if ((userPosition.latitude > item.latitude - range) &&
            (userPosition.latitude < item.latitude + range)) {
          if ((userPosition.longitude > item.longitude - range) &&
              (userPosition.longitude < item.longitude + range)) {
            numberOfFiresNearby++;
          }
        }
      }
    } catch (err) {
      print(err);
    }
    return numberOfFiresNearby;
  }

  Future<void> startFireNotification() async {
    final int numberOfFires = await _checkFires();
    print(numberOfFires);
    if (numberOfFires > 0) {
      await createFireNotification(numberOfFires);
    }
  }
}
