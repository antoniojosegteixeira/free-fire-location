import 'package:geolocator/geolocator.dart';

class LocationService {
  bool isEnabled = false;

  Future<void> verifyEnablement() async {
    isEnabled = await Geolocator.isLocationServiceEnabled();
  }

  Future<Position> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Permission denied Forever');
      }
    }
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
