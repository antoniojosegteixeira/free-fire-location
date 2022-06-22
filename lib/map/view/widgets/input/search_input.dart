import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return TextField(
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              controller.clear();
            },
          ),
          hintText: 'Search...',
          border: InputBorder.none),
    );
  }
}
