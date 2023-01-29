import 'package:free_fire_location/features/map/data/models/fire_page_response.dart';

abstract class FireInfoDatasource {
  Future<FirePageModel> getFireLocations({
    required int amount,
  });
}
