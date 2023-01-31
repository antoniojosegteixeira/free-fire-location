import 'package:free_fire_location/core/infra/http_request.dart';
import 'package:free_fire_location/core/infra/request_config/weather_config.dart';
import 'package:free_fire_location/features/map/data/models/weather_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class WeatherInfoDatasource {
  Future<WeatherModel> getWeatherByCoordinates({
    required LatLng latLng,
  });
}

class WeatherInfoDatasourceImpl implements WeatherInfoDatasource {
  WeatherInfoDatasourceImpl({required this.client});

  final HttpRequest client;

  @override
  Future<WeatherModel> getWeatherByCoordinates({required LatLng latLng}) async {
    final requestUrl = WeatherConfig().createRequestUrl(latLng: latLng);

    final response = await client.doRequest(
      endpoint: requestUrl,
      requestMethod: RequestMethod.get,
    );

    final WeatherModel weatherResponse =
        WeatherModel.fromJson(response.data, latLng);

    return weatherResponse;
  }
}
