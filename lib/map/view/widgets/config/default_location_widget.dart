import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';

class DefaultLocationWidget extends StatelessWidget {
  const DefaultLocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 25.0),
          child: const Text(
            'Localização padrão',
            style: TextStyle(color: AppColors.white, fontSize: 17.0),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: TextField(
              decoration: InputDecoration(
            hintText: 'Buscar endereço...',
            border: OutlineInputBorder(),
            fillColor: AppColors.white,
            filled: true,
            isDense: true,
          )),
        ),
        Row(
          children: [
            const Padding(padding: EdgeInsets.only(left: 25.0)),
            Image.asset('assets/images/house.png'),
            const Padding(padding: EdgeInsets.only(left: 5)),
            const Text('Rua das Camélias, 26, Campinas',
                style: TextStyle(color: AppColors.white, fontSize: 16)),
          ],
        )
      ],
    );
  }
}
