import 'package:free_fire_location/features/map/data/models/fire_info_response.dart';
import 'package:free_fire_location/features/map/data/models/fire_page_response.dart';
import 'package:free_fire_location/features/map/domain/entities/fire_page_entity.dart';

class DataMock {
  static FirePageEntity tFirePageModel = const FirePageModel(coordinatesList: [
    FireInfoModel(
        latitude: -6.410660,
        longitude: -35.088500,
        satelliteName: 'NOAA-20',
        date: '2023-02-01 02:57:00'),
    FireInfoModel(
        latitude: -6.409820,
        longitude: -35.093180,
        satelliteName: 'NOAA-20',
        date: '2023-02-01 02:57:00'),
    FireInfoModel(
        latitude: -6.410660,
        longitude: -35.088500,
        satelliteName: 'NOAA-20',
        date: '2023-02-01 02:57:00'),
  ]);
}
