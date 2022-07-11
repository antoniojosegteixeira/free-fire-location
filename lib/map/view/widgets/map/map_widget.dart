import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/map/view/cubit/fire/fire_cubit.dart';
import 'package:free_fire_location/map/view/cubit/firebase/firebase_cubit.dart';
import 'package:free_fire_location/map/view/cubit/firebase/firebase_state.dart';
import 'package:free_fire_location/map/view/cubit/location/location_cubit.dart';
import 'package:free_fire_location/map/view/cubit/location/location_state.dart';
import 'package:free_fire_location/map/view/cubit/map_controller/map_controller_cubit.dart';
import 'package:free_fire_location/map/view/cubit/options/options_cubit.dart';
import 'package:free_fire_location/map/view/cubit/places_search/places_search_cubit.dart';
import 'package:free_fire_location/map/view/cubit/user_fire/user_fire_cubit.dart';
import 'package:free_fire_location/map/view/cubit/weather_info/weather_info_cubit.dart';
import 'package:free_fire_location/map/view/pages/splash_page.dart';
import 'package:free_fire_location/map/view/widgets/map/add_user_fire/add_user_fire.dart';
import 'package:free_fire_location/map/view/widgets/map/input/search_input.dart';
import 'package:free_fire_location/utils/generate_markers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  static const LatLng _center = LatLng(-13.616770, -50.946247);
  final Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController activeController) {
    _controller.complete(activeController);

    context
        .read<WeatherInfoCubit>()
        .setcustomInfoWindowController(activeController);
    context.read<MapControllerCubit>().addActiveController(activeController);
  }

  @override
  Widget build(BuildContext context) {
    final FocusScopeNode focusScopeNode = FocusScope.of(context);
    return BlocBuilder<FirebaseCubit, FirebaseState>(
      builder: (firebaseContext, firebaseState) {
        if (firebaseState is FirebaseSuccess) {
          return BlocBuilder<FireCubit, FireState>(
            builder: ((fireContext, fireState) {
              if (fireState is FireSuccess) {
                return BlocBuilder<OptionsCubit, MapType>(
                  builder: ((optionsContext, mapType) {
                    final CustomInfoWindowController
                        customInfoWindowController = context
                            .read<WeatherInfoCubit>()
                            .customInfoWindowController;

                    // Setting markers
                    List<Marker> generatedMarkers =
                        GenerateMarkers.generateMarkers(
                            customMarkerImage: fireState.markerImage,
                            coordinatesList: fireState.coordinatesList,
                            customInfoWindowController: context
                                .read<WeatherInfoCubit>()
                                .customInfoWindowController,
                            callback: (LatLng latLng) {
                              context
                                  .read<WeatherInfoCubit>()
                                  .getWeatherInfoByCoordinates(latLng: latLng);
                            });

                    List<Marker> generatedUserMarkers =
                        GenerateMarkers.generateUserMarker(
                            customUserMarkerImage:
                                firebaseState.userMarkerImage,
                            coordinatesList: firebaseState.userFireList,
                            customInfoWindowController: context
                                .read<WeatherInfoCubit>()
                                .customInfoWindowController,
                            callback: (LatLng latLng) {
                              context
                                  .read<WeatherInfoCubit>()
                                  .getWeatherInfoByCoordinates(latLng: latLng);
                            });

                    final Set<Marker> combinedMarkers = <Marker>{
                      ...generatedUserMarkers,
                      ...generatedMarkers
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
                                  target: LatLng(
                                      locationState.position.latitude,
                                      locationState.position.longitude),
                                  zoom: 5.0,
                                ),
                                onTap: (_) {
                                  customInfoWindowController.hideInfoWindow!();
                                  if (!focusScopeNode.hasPrimaryFocus) {
                                    focusScopeNode.unfocus();
                                  }
                                  context
                                      .read<PlacesSearchCubit>()
                                      .setEmptySuggestions();
                                },
                                onCameraMove: (_) {
                                  customInfoWindowController.onCameraMove!();
                                },
                                onLongPress: (LatLng coordinates) {
                                  context.read<UserFireCubit>().openModal(
                                        coordinates: coordinates,
                                      );
                                },
                              ),
                              CustomInfoWindow(
                                controller: customInfoWindowController,
                                height: 220,
                                width: 250,
                                offset: 80,
                              ),
                              const AddUserFire(),
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
                                onLongPress: (LatLng coordinates) {
                                  context.read<UserFireCubit>().openModal(
                                        coordinates: coordinates,
                                      );
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
                              const AddUserFire(),
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
          );
        }

        if (firebaseState is FirebaseError) {
          print("ERROR");
          print(firebaseState.error);
          return const Text("FireBase error");
        }

        if (firebaseState is FirebaseLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return const Text("FireBase NOTHING error");
      },
    );
  }
}
