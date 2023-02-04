import 'package:free_fire_location/features/map/domain/entities/fire_page_entity.dart';

abstract class FireInfoDatasource {
  Future<FirePageEntity> getFireLocations({
    required int amount,
  });
}
