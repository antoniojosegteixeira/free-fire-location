import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/map/view/cubit/fire/fire_cubit.dart';
import 'package:free_fire_location/map/view/cubit/options/options_cubit.dart';
import 'package:free_fire_location/map/view/pages/splash_page.dart';
import 'package:free_fire_location/utils/generate_markers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller = Completer();
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  // Implement user coordinates

  static const LatLng _center = LatLng(-13.616770, -50.946247);

  void _onMapCreated(GoogleMapController controller) {
    _customInfoWindowController.googleMapController = controller;
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FireCubit, FireState>(
      builder: ((fireContext, fireState) {
        if (fireState is FireSuccess) {
          return BlocBuilder<OptionsCubit, MapType>(
              builder: ((optionsContext, mapType) {
            Set<Marker> generatedMarkers = GenerateMarkers.generate(
              customMarkerImage: fireState.markerImage,
              coordinatesList: fireState.coordinatesList,
              customInfoWindowController: _customInfoWindowController,
            ).toSet();

            return Stack(
              children: [
                GoogleMap(
                  mapToolbarEnabled: true,
                  mapType: mapType,
                  compassEnabled: true,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  onMapCreated: _onMapCreated,
                  markers: generatedMarkers,
                  initialCameraPosition: const CameraPosition(
                    target: _center,
                    zoom: 2.0,
                  ),
                  onTap: (_) {
                    _customInfoWindowController.hideInfoWindow!();
                  },
                  onCameraMove: (_) {
                    _customInfoWindowController.onCameraMove!();
                  },
                ),
                CustomInfoWindow(
                  controller: _customInfoWindowController,
                  height: 75,
                  width: 150,
                  offset: 50,
                ),
              ],
            );
          }));
        }

        return const SplashPage();
      }),
    );
  }
}
