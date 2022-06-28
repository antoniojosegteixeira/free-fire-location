import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/map/models/map_types.dart';
import 'package:free_fire_location/map/view/cubit/options/options_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTypeButton extends StatefulWidget {
  const MapTypeButton({Key? key}) : super(key: key);

  @override
  State<MapTypeButton> createState() => _MapTypeButtonState();
}

class _MapTypeButtonState extends State<MapTypeButton> {
  String typeToString(MapType type) {
    switch (type) {
      case MapType.normal:
        return 'Normal';
      case MapType.satellite:
        return 'Satélite';
      case MapType.terrain:
        return 'Terreno';
      case MapType.hybrid:
        return 'Híbrido';
      default:
        return 'Normal';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OptionsCubit, MapType>(builder: ((context, mapType) {
      return PopupMenuButton(
          icon: const MapIcon(),
          iconSize: 55,
          initialValue: mapType,
          elevation: 16,
          onSelected: (MapType? newValue) {
            if (newValue != null) {
              BlocProvider.of<OptionsCubit>(context).changeMapType(newValue);
            }
          },
          itemBuilder: (BuildContext context) {
            return MapTypes.types.map<PopupMenuEntry<MapType>>((MapType value) {
              return PopupMenuItem<MapType>(
                value: value,
                child: Text(typeToString(value)),
              );
            }).toList();
          });
    }));
  }
}

class MapIcon extends StatelessWidget {
  const MapIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.map,
        size: 32,
        color: AppColors.white,
      ),
    );
  }
}
