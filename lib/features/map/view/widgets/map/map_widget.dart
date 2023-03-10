import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/features/map/view/cubit/fire/fire_cubit.dart';
import 'package:free_fire_location/features/map/view/cubit/location/location_cubit.dart';
import 'package:free_fire_location/features/map/view/cubit/location/location_state.dart';
import 'package:free_fire_location/features/map/view/cubit/map_controller/map_controller_cubit.dart';
import 'package:free_fire_location/features/map/view/cubit/options/options_cubit.dart';
import 'package:free_fire_location/features/map/view/cubit/places_search/places_search_cubit.dart';
import 'package:free_fire_location/features/map/view/cubit/user_fire/user_fire_cubit.dart';
import 'package:free_fire_location/features/map/view/cubit/weather_info/weather_info_cubit.dart';
import 'package:free_fire_location/features/map/view/widgets/map/modal/fire_add_confirmation_modal.dart';

import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  static const LatLng _center = LatLng(-13.616770, -50.946247);
  final Completer<GoogleMapController> _controller = Completer();

  late final WeatherInfoCubit weatherInfoCubit;
  late final UserFireCubit userFireCubit;
  late MapControllerCubit mapControllerCubit;
  late final FireCubit fireCubit;

  List<Marker> userMarkers = [];

  void _onMapCreated(GoogleMapController activeController) {
    _controller.complete(activeController);

    weatherInfoCubit.setcustomInfoWindowController(activeController);
    mapControllerCubit.addActiveController(activeController);
  }

  @override
  void initState() {
    weatherInfoCubit = GetIt.I<WeatherInfoCubit>();
    userFireCubit = GetIt.I<UserFireCubit>();
    mapControllerCubit = GetIt.I<MapControllerCubit>();
    fireCubit = GetIt.I<FireCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserFireCubit, UserFireState>(
      listener: (context, state) {
        if (state is UserFireGetFireSuccess) {
          setState(() {});
        }
      },
      bloc: userFireCubit..getUserFires(),
      child: BlocBuilder<FireCubit, FireState>(
        builder: ((fireContext, fireState) {
          if (fireState is FireSuccess) {
            return BlocBuilder<OptionsCubit, MapType>(
              builder: ((optionsContext, mapType) {
                final CustomInfoWindowController customInfoWindowController =
                    weatherInfoCubit.customInfoWindowController;

                final Set<Marker> combinedMarkers = <Marker>{
                  ...fireCubit.generateMarkers(
                    customMarkerImage: fireState.markerImage,
                    coordinatesList: fireState.coordinatesList,
                  ),
                  ...userFireCubit.userMarkers,
                };

                return BlocBuilder<LocationCubit, LocationState>(
                  builder: ((locationContext, locationState) {
                    if (locationState is LocationEnabled) {
                      return Stack(
                        children: [
                          GoogleMap(
                            mapToolbarEnabled: true,
                            mapType: mapType,
                            compassEnabled: true,
                            myLocationButtonEnabled: false,
                            myLocationEnabled: true,
                            onMapCreated: _onMapCreated,
                            markers: combinedMarkers,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(locationState.position.latitude,
                                  locationState.position.longitude),
                              zoom: 5.0,
                            ),
                            onTap: (_) {
                              customInfoWindowController.hideInfoWindow!();

                              FocusManager.instance.primaryFocus?.unfocus();
                              context
                                  .read<PlacesSearchCubit>()
                                  .setEmptySuggestions();
                            },
                            onCameraMove: (_) {
                              customInfoWindowController.onCameraMove!();
                            },
                            onLongPress: (latLng) {
                              openAddMapConfirmation(
                                context: context,
                                latLng: latLng,
                              );
                            },
                          ),
                          CustomInfoWindow(
                            controller: customInfoWindowController,
                            height: 220,
                            width: 250,
                            offset: 80,
                          ),
                        ],
                      );
                    } else if (locationState is LocationDisabled) {
                      return Stack(
                        children: [
                          GoogleMap(
                            mapToolbarEnabled: true,
                            mapType: mapType,
                            compassEnabled: true,
                            myLocationButtonEnabled: false,
                            myLocationEnabled: true,
                            onMapCreated: _onMapCreated,
                            markers: combinedMarkers,
                            initialCameraPosition: const CameraPosition(
                              target: _center,
                              zoom: 5.0,
                            ),
                            onTap: (_) {
                              customInfoWindowController.hideInfoWindow!();
                            },
                            onCameraMove: (_) {
                              customInfoWindowController.onCameraMove!();
                            },
                          ),
                          CustomInfoWindow(
                            controller: customInfoWindowController,
                            height: 220,
                            width: 250,
                            offset: 80,
                          ),
                        ],
                      );
                    } else if (locationState is LocationInitial) {
                      return Container();
                    }

                    return Container();
                  }),
                );
              }),
            );
          }

          return const Text("Error");
        }),
      ),
    );
  }
}
