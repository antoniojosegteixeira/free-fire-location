import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/map/data/repositories/places_info_repository.dart';
import 'package:free_fire_location/map/data/repositories/places_search_repository.dart';
import 'package:free_fire_location/map/data/response_models/places_info_response.dart';
import 'package:free_fire_location/map/view/cubit/map_controller/map_controller_cubit.dart';
import 'package:free_fire_location/map/view/cubit/places_search/places_search_cubit.dart';
import 'package:free_fire_location/map/view/cubit/places_search/places_search_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchInput extends StatelessWidget {
  Timer _timer = Timer(const Duration(days: 1), () {});
  SearchInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    FocusScopeNode inputFocusScopeNode = FocusScope.of(context);

    return BlocBuilder<MapControllerCubit, MapControllerState>(
      builder: (mapControllerContext, mapControllerState) {
        if (mapControllerState is MapControllerCompleted) {
          return BlocBuilder<PlacesSearchCubit, PlacesSearchState>(
            builder: (placesSearchContext, placesSearchState) {
              if (placesSearchState is PlacesSearchResults) {
                return Column(
                  children: [
                    TextField(
                      onSubmitted: (value) {
                        placesSearchContext
                            .read<PlacesSearchCubit>()
                            .setEmptySuggestions();
                        if (!inputFocusScopeNode.hasPrimaryFocus) {
                          inputFocusScopeNode.unfocus();
                        }
                      },
                      controller: controller,
                      onChanged: (value) {
                        _timer.cancel();
                        _timer =
                            Timer(const Duration(milliseconds: 750), () async {
                          placesSearchState.places = await context
                              .read<PlacesSearchCubit>()
                              .getAutoCompletePlaces(value);
                        });
                      },
                      onEditingComplete: () {
                        placesSearchContext
                            .read<PlacesSearchCubit>()
                            .setEmptySuggestions();
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.white,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.delete,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: AppColors.delete,
                          ),
                          onPressed: () {
                            controller.clear();
                            placesSearchContext
                                .read<PlacesSearchCubit>()
                                .setEmptySuggestions();
                          },
                        ),
                        hintText: 'Buscar...',
                        hintStyle: const TextStyle(color: AppColors.delete),
                        border: InputBorder.none,
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          color: AppColors.black,
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: Container(
                                color: AppColors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: placesSearchState.places
                                      .map(
                                        (place) => GestureDetector(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                35, 3, 15, 8),
                                            child: Text(place.description),
                                          ),
                                          onTap: () async {
                                            placesSearchContext
                                                .read<PlacesSearchCubit>()
                                                .setEmptySuggestions();
                                            final mapController =
                                                mapControllerState
                                                    .activeController;
                                            PlacesInfoRepository
                                                placesInfoRepository =
                                                PlacesInfoRepository();
                                            PlacesInfoResponse? location =
                                                await placesInfoRepository
                                                    .getPlacesInfo(
                                                        place.placeId);
                                            mapController.animateCamera(
                                              CameraUpdate.newCameraPosition(
                                                CameraPosition(
                                                  target: LatLng(
                                                      location!.latitude,
                                                      location.longitude),
                                                  zoom: 12.0,
                                                ),
                                              ),
                                            );
                                            placesSearchContext
                                                .read<PlacesSearchCubit>()
                                                .setEmptySuggestions();
                                            if (!inputFocusScopeNode
                                                .hasPrimaryFocus) {
                                              inputFocusScopeNode.unfocus();
                                            }
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              }
              if (placesSearchState is PlacesSearchError) {
                return const TextField(
                  decoration: InputDecoration(hintText: 'ERRO'),
                );
              }
              return Container();
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
