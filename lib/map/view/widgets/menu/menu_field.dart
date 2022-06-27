import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';

class MenuField extends StatelessWidget {
  final String description;
  final Widget? nav;

  const MenuField({
    Key? key,
    required this.description,
    this.nav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 15),
        alignment: Alignment.centerLeft,
        child: ElevatedButton(
            onPressed: () {
              if (nav != null) {
                Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => nav as Widget));
              }
            },
            style: ElevatedButton.styleFrom(
              primary: AppColors.darkBrown,
              elevation: 0,
            ),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16),
            )));
  }
}
