import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/colors.dart';

Future<dynamic> openAddMapInfo({required BuildContext context}) => showDialog(
      context: context,
      builder: (context) {
        return const LayerModal();
      },
    );

class LayerModal extends StatelessWidget {
  const LayerModal({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomPopup();
  }
}

class CustomPopup extends StatelessWidget {
  const CustomPopup({
    super.key,
  });

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
                const Text(
                  'Para adicionar um registro de incêndio pressione a tela no local da ocorrência por alguns segundos.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
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
          ),
        )
      ],
    );
  }
}
