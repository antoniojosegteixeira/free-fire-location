import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/map/view/cubit/fire/fire_cubit.dart';
import 'package:free_fire_location/map/view/widgets/map/controls/location_button.dart';
import 'package:free_fire_location/map/view/widgets/map/controls/map_type_button.dart';
import 'package:free_fire_location/map/view/widgets/map/controls/time_button.dart';

class ControlBox extends StatelessWidget {
  const ControlBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FireCubit, FireState>(builder: ((context, state) {
      if (state is FireSuccess) {
        return SizedBox(
          child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(4, 80, 4, 0),
                child: MapTypeButton(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0.0),
                child: TimeButton(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: LocationButton(),
              ),
            ],
          ),
        );
      }
      return Container();
    }));
  }
}
