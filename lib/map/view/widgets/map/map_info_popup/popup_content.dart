import 'package:flutter/material.dart';
import 'package:free_fire_location/consts/app_text_styles.dart';
import 'package:free_fire_location/consts/colors.dart';
import 'package:free_fire_location/map/data/response_models/weather_response.dart';

class PopUpContent extends StatelessWidget {
  final WeatherResponse weather;

  const PopUpContent({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  weather.name,
                  style: AppTextStyles.titleBold,
                  textAlign: TextAlign.center,
                ),
                Text(
                  weather.region,
                  style: AppTextStyles.subtitle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "${weather.latitude}, ${weather.longitude}",
                  style: AppTextStyles.subtitle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 10.0),
            child: Column(
              children: [
                PopUpItem(
                  text: "${weather.temperature} °C",
                  icon: Icons.thermostat_sharp,
                  color: AppColors.primary,
                ),
                PopUpItem(
                  text: "${weather.wind}km/h - ${weather.windDir}",
                  icon: Icons.air,
                  color: AppColors.lightSilver,
                ),
                PopUpItem(
                  text: "${weather.precipitation}%",
                  icon: Icons.umbrella_sharp,
                  color: AppColors.mediumBlue,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PopUpItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  const PopUpItem({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 32,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            text,
            style: AppTextStyles.heading,
          ),
        )
      ],
    );
  }
}
