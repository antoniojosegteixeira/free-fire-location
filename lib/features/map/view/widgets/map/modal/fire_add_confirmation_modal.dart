import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/features/map/view/cubit/user_fire/user_fire_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<dynamic> openAddMapConfirmation({
  required BuildContext context,
  required LatLng latLng,
}) =>
    showDialog(
      context: context,
      builder: (context) {
        return CustomPopup(
          latLng: latLng,
        );
      },
    );

class CustomPopup extends StatelessWidget {
  const CustomPopup({
    super.key,
    required this.latLng,
  });

  final LatLng latLng;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      children: [
        SizedBox(
          width: 326,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 15, bottom: 5),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Text(
                    'Deseja adicionar um registro de incêndio nesta localidade?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  '${latLng.latitude.toStringAsFixed(5)}, ${latLng.longitude.toStringAsFixed(5)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.darkSilver,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 140,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.all(12),
                            elevation: 0,
                          ),
                          onPressed: () {
                            GetIt.I<UserFireCubit>()
                                .addUserFire(latLng: latLng);
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: const Text(
                            'Adicionar',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 140,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.grey,
                            padding: const EdgeInsets.all(12),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: const Text(
                            'Fechar',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
