import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/map/view/cubit/fire/fire_cubit.dart';
import 'package:free_fire_location/map/view/pages/splash_page.dart';
import 'package:free_fire_location/map/view/widgets/appbar/custom_app_bar.dart';
import 'package:free_fire_location/map/view/widgets/controls/control_box.dart';
import 'package:free_fire_location/map/view/widgets/map_widget.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: AppColors.darkBrown),
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
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: const [
                      MapWidget(),
                      CustomAppBar(),
                      ControlBox(),
                    ],
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
