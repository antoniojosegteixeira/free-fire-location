import 'dart:async';

import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/map/data/repositories/places_search_repository.dart';

class SearchInput extends StatelessWidget {
  Timer _timer = Timer(const Duration(days: 1), () {});
  SearchInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return TextField(
      controller: controller,
      onChanged: (value) {
        PlacesSearchRepository places = PlacesSearchRepository();
        _timer.cancel();
        _timer = Timer(const Duration(milliseconds: 750), () async {
          List<dynamic> suggestion = await places.getAutoCompletePlaces(value);
          print(suggestion[0].description);
          print(suggestion[0].placeId);
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
    );
  }
}
