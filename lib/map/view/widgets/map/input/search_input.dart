import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/map/data/repositories/places_search_repository.dart';
import 'package:free_fire_location/map/view/cubit/map_controller/map_controller_cubit.dart';
import 'package:free_fire_location/map/view/cubit/places_search/places_search_cubit.dart';
import 'package:free_fire_location/map/view/cubit/places_search/places_search_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchInput extends StatelessWidget {
  Timer _timer = Timer(const Duration(days: 1), () {});
  String _labelText = '';
  SearchInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return BlocBuilder<MapControllerCubit, MapControllerState>(
      builder: (mapControllerContext, mapControllerState) {
        if (mapControllerState is MapControllerCompleted) {
          return BlocBuilder<PlacesSearchCubit, PlacesSearchState>(
            builder: (placesSearchContext, placesSearchState) {
              if (placesSearchState is PlacesSearchResults) {
                return Column(
                  children: [
                    TextField(
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
                                      .map((place) => GestureDetector(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      35, 3, 15, 8),
                                              child: Text(place.description),
                                            ),
                                            onTap: () {
                                              controller.text =
                                                  place.description;
                                              final mapController =
                                                  mapControllerState
                                                      .activeController;
                                              mapController.animateCamera(
                                                  CameraUpdate
                                                      .newCameraPosition(
                                                CameraPosition(
                                                  target: LatLng(-15, -55),
                                                  zoom: 10.0,
                                                ),
                                              ));
                                            },
                                          ))
                                      .toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
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
