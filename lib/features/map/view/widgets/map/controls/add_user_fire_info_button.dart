import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/features/map/view/widgets/map/modal/add_fire_modal.dart';

class AddUserFireInfoButton extends StatefulWidget {
  const AddUserFireInfoButton({Key? key}) : super(key: key);

  @override
  State<AddUserFireInfoButton> createState() => _AddUserFireInfoButtonState();
}

class _AddUserFireInfoButtonState extends State<AddUserFireInfoButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(12),
        elevation: 0,
      ),
      onPressed: () {
        openAddMapInfo(context: context);
      },
      child: const Icon(
        Icons.add,
        size: 32,
      ),
    );
  }
}
