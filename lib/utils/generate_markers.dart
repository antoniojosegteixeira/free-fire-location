import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:free_fire_location/map/models/fire_info.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GenerateMarkers {
  static List<Marker> generate({
    required BitmapDescriptor customMarkerImage,
    required List<FireInfo> coordinatesList,
    required CustomInfoWindowController customInfoWindowController,
  }) {
    List<Marker> markers = coordinatesList.map((item) {
      final LatLng latlong = LatLng(item.latitude, item.longitude);

      return Marker(
          markerId: MarkerId('${item.latitude}${item.longitude}${item.date}'),
          position: latlong,
          infoWindow: InfoWindow(title: '${item.satelliteName} - ${item.date}'),
          icon: customMarkerImage,
          onTap: () {
            customInfoWindowController.addInfoWindow!(
              const Text("MAP INFO"),
              latlong,
            );
          });
    }).toList();

    return markers;
  }
}
