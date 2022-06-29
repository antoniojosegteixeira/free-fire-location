import 'package:free_fire_location/map/models/fire_info.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GenerateMarkers {
  static generate(
      {required BitmapDescriptor customMarkerImage,
      required List<FireInfo> coordinatesList}) {
    List<Marker> markers = coordinatesList.map((item) {
      return Marker(
          markerId: MarkerId('${item.latitude}${item.longitude}${item.date}'),
          position: LatLng(item.latitude, item.longitude),
          infoWindow: InfoWindow(title: '${item.satelliteName} - ${item.date}'),
          icon: customMarkerImage);
    }).toList();

    return markers;
  }
}
