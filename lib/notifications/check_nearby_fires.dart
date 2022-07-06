import 'package:free_fire_location/map/data/repositories/fire_repository.dart';
import 'package:free_fire_location/map/models/fire_page.dart';
import 'package:free_fire_location/utils/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CheckNearbyFires {
  double range = 0.1;

  Future<LatLng> _getLocation() async {
    LocationService locationService = LocationService();
    final Position location = await locationService.getLocation();
    return LatLng(location.latitude, location.longitude);
  }

  Future<int> check() async {
    FireRepository repository = FireRepository();
    int numberOfFiresNearby = 0;

    try {
      final FirePage fireInfo = await repository.getFireLocations(2);
      final LatLng userPosition = await _getLocation();

      print("position: $userPosition");

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
}
