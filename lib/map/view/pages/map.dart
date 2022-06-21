import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/map/view/cubit/fire/fire_cubit.dart';
import 'package:free_fire_location/map/view/pages/splash.dart';
import 'package:free_fire_location/map/view/widgets/map_widget.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: Scaffold(
        body: SafeArea(
          child: BlocBuilder<FireCubit, FireState>(
            builder: ((context, state) {
              if (state is FireInitial) {
                return const SplashPage();
              }

              if (state is FireLoading) {
                return Stack(
                  children: const [
                    SplashPage(),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 320),
                        child:
                            CircularProgressIndicator(color: AppColors.white),
                      ),
                    ),
                  ],
                );
              }

              if (state is FireError) {
                return const Center(
                  child: Text('Error'),
                );
              }

              if (state is FireSuccess) {
                return const Center(
                  child: SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: MapWidget(),
                  ),
                );
              }

              return const SplashPage();
            }),
          ),
        ),
      ),
    );
  }
}
