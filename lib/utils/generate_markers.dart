import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:free_fire_location/map/data/response_models/user_fire_response.dart';
import 'package:free_fire_location/map/models/fire_info.dart';
import 'package:free_fire_location/map/view/widgets/map/map_info_popup/map_info_popup.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GenerateMarkers {
  static List<Marker> generateMarkers({
    required BitmapDescriptor customMarkerImage,
    required List<FireInfo> coordinatesList,
    required CustomInfoWindowController customInfoWindowController,
    required Function callback,
  }) {
    List<Marker> markers = coordinatesList.map((item) {
      final LatLng latLng = LatLng(item.latitude, item.longitude);

      return Marker(
          markerId: MarkerId('${item.latitude}${item.longitude}${item.date}'),
          position: latLng,
          icon: customMarkerImage,
          onTap: () {
            callback(latLng);
            customInfoWindowController.addInfoWindow!(
              const MapInfoPopup(),
              latLng,
            );
          });
    }).toList();

    return markers;
  }

  static List<Marker> generateUserMarker({
    required BitmapDescriptor customUserMarkerImage,
    required List<UserFireResponse> coordinatesList,
    required CustomInfoWindowController customInfoWindowController,
    required Function callback,
  }) {
    List<Marker> markers = coordinatesList.map((item) {
      final LatLng latLng = LatLng(item.latitude, item.longitude);

      return Marker(
          markerId: MarkerId('${item.latitude}${item.longitude}${item.date}'),
          position: latLng,
          icon: customUserMarkerImage,
          onTap: () {
            callback(latLng);
            customInfoWindowController.addInfoWindow!(
              const MapInfoPopup(),
              latLng,
            );
          });
    }).toList();

    return markers;
  }
}
