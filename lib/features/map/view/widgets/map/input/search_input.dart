import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/features/map/view/cubit/map_controller/map_controller_cubit.dart';
import 'package:free_fire_location/features/map/view/cubit/places_search/places_search_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  Timer _timer = Timer(const Duration(days: 1), () {});
  final TextEditingController controller = TextEditingController();
  late final PlacesSearchCubit placesSearchCubit;
  late final MapControllerCubit mapControllerCubit;
  late FocusScopeNode inputFocusScopeNode;

  @override
  void initState() {
    placesSearchCubit = context.read<PlacesSearchCubit>();
    mapControllerCubit = context.read<MapControllerCubit>();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    inputFocusScopeNode = FocusScope.of(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapControllerCubit, MapControllerState>(
      builder: (mapControllerContext, mapControllerState) {
        if (mapControllerState is MapControllerCompleted) {
          return BlocConsumer<PlacesSearchCubit, PlacesSearchState>(
            listener: (context, state) {
              if (state is PlaceInfoLocation) {
                mapControllerCubit.moveCameraToPlace(
                  latlng: LatLng(
                      state.placeInfo.latitude, state.placeInfo.longitude),
                  zoom: 7,
                );
              }
            },
            builder: (placesSearchContext, placesSearchState) {
              return SizedBox(
                child: Column(
                  children: [
                    TextField(
                      autofocus: true,
                      onSubmitted: (value) {
                        placesSearchCubit.setEmptySuggestions();
                        inputFocusScopeNode.unfocus();
                      },
                      controller: controller,
                      onChanged: (value) {
                        _timer.cancel();
                        _timer =
                            Timer(const Duration(milliseconds: 750), () async {
                          placesSearchCubit.getAutoCompletePlaces(value);
                        });
                      },
                      onEditingComplete: () {
                        placesSearchCubit.setEmptySuggestions();
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
                            placesSearchCubit.setEmptySuggestions();
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
                                            placesSearchCubit
                                                .getSearchPlaceLocation(
                                              place.placeId,
                                            );
                                            controller.clear();
                                            placesSearchCubit
                                                .setEmptySuggestions();

                                            inputFocusScopeNode.unfocus();
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
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
