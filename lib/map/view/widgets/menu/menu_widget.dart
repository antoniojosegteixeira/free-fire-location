import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          color: AppColors.darkBrown,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(20)),
              SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset('assets/images/splash.png')),
              const SizedBox(height: 10),
              const Center(
                  child: Text('FreeFire Locator',
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold))),
              const SizedBox(height: 57),
              GestureDetector(
                child: const Text(
                  'Adicionar local padrão',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.white,
                  ),
                ),
                onTap: () {},
                onLongPress: () {},
              ),
              const SizedBox(height: 20),
              GestureDetector(
                child: const Text('Configurações',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.white,
                    )),
                onTap: () {},
                onLongPress: () {},
              ),
              const SizedBox(height: 20),
              GestureDetector(
                child: const Text('Sobre',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.white,
                    )),
                onTap: () {},
                onLongPress: () {},
              ),
              Expanded(child: Container()),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: AppColors.primary),
                  onPressed: () {},
                  child: const Text('Chamar corpo de bombeiros'))
            ],
          )),
    );
  }
}
