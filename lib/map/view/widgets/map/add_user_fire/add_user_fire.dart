import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/consts/app_text_styles.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/map/view/cubit/firebase/firebase_cubit.dart';
import 'package:free_fire_location/map/view/cubit/firebase/firebase_state.dart';
import 'package:free_fire_location/map/view/cubit/user_fire/user_fire_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddUserFire extends StatelessWidget {
  const AddUserFire({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserFireCubit, UserFireState>(
      builder: (context, state) {
        if (state is UserFireOpen) {
          return BlocBuilder<FirebaseCubit, FirebaseState>(
            builder: (context, firebaseState) {
              if (firebaseState is FirebaseSuccess) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 90.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 180,
                        width: 280,
                        child: Card(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          "Deseja registrar uma ocorrência de incêndio?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppColors.darkBrown,
                                            fontSize: 18,
                                          )),
                                    ),
                                    Text(
                                      "${state.coordinates.latitude.toString().substring(0, 8)}, ${state.coordinates.longitude.toString().substring(0, 8)}",
                                      style: AppTextStyles.subtitle,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                context
                                                    .read<FirebaseCubit>()
                                                    .postUserReport(
                                                        state.coordinates
                                                            .latitude,
                                                        state.coordinates
                                                            .longitude);
                                                context
                                                    .read<UserFireCubit>()
                                                    .closeModal();
                                              },
                                              child: const Text("Sim")),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                context
                                                    .read<UserFireCubit>()
                                                    .closeModal();
                                              },
                                              child: Text("Não")),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return const Text("");
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
