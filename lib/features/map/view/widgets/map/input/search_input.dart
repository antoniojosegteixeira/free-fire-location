import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/features/map/view/cubit/map_controller/map_controller_cubit.dart';
import 'package:free_fire_location/features/map/view/widgets/map/places_search/places_search_cubit.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  Timer _timer = Timer(const Duration(days: 1), () {});
  final TextEditingController controller = TextEditingController();
  late final PlacesSearchCubit placesSearchCubit;

  @override
  void initState() {
    placesSearchCubit = context.read<PlacesSearchCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        placesSearchCubit.setEmptySuggestions();
                        if (!inputFocusScopeNode.hasPrimaryFocus) {
                          inputFocusScopeNode.unfocus();
                        }
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
                                                .setEmptySuggestions();
                                            /*
                                            final mapController =
                                                mapControllerState
                                                    .activeController;
                                                    */

                                            placesSearchCubit
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
