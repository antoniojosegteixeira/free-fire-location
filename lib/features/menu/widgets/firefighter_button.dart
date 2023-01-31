import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class FirefighterButton extends StatelessWidget {
  const FirefighterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary, fixedSize: const Size(244, 43)),
      onPressed: () async {
        Uri uri = Uri(scheme: 'tel', path: '193');
        await launchUrl(uri);
      },
      child: const Text(
        'Chamar corpo de bombeiros',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
