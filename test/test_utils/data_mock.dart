import 'package:free_fire_location/features/map/data/models/fire_info_response.dart';
import 'package:free_fire_location/features/map/data/models/fire_page_response.dart';
import 'package:free_fire_location/features/map/data/models/places_autocomplete_model.dart';
import 'package:free_fire_location/features/map/data/models/places_info_model.dart';
import 'package:free_fire_location/features/map/data/models/weather_model.dart';
import 'package:free_fire_location/features/map/domain/entities/fire_page_entity.dart';

class DataMock {
  static FirePageEntity tFirePageInpeModel = const FirePageModel(
    coordinatesList: [
      FireInfoModel(
        latitude: -6.40982,
        longitude: -35.09318,
        satelliteName: 'NOAA-20',
        date: '2023-02-01 02:57:00',
      ),
      FireInfoModel(
        latitude: -6.41066,
        longitude: -35.0885,
        satelliteName: 'NOAA-20',
        date: '2023-02-01 02:57:00',
      ),
    ],
  );

  static FirePageEntity tFirePageNasaModel =
      const FirePageModel(coordinatesList: [
    FireInfoModel(
      latitude: -5.61487,
      longitude: -35.67607,
      satelliteName: 'VIIRS',
      date: '2023-02-02',
    ),
    FireInfoModel(
      latitude: -5.61462,
      longitude: -35.67822,
      satelliteName: 'VIIRS',
      date: '2023-02-02',
    ),
  ]);

  static PlacesAutocompleteModel tPlacesAutocompleteModel =
      const PlacesAutocompleteModel(
    description: 'Campinas, SP, Brasil',
    placeId: 'ChIJJWNL5x3GyJQRKsJ4IWo65Rc',
  );

  static PlacesInfoModel tPlacesInfoModel =
      const PlacesInfoModel(latitude: -22.9099384, longitude: -47.0626332);

  static WeatherModel tWeatherModel = const WeatherModel(
    name: 'Quiindy',
    region: 'Paraguari',
    country: 'Paraguay',
    temperature: 29.3,
    wind: 15.1,
    windDir: 'SSE',
    precipitation: 0.0,
    latitude: -15.0,
    longitude: -56.0,
  );

  static FireInfoModel tFireInfoNasaModel = const FireInfoModel(
    latitude: -5.168148,
    longitude: -35.21868,
    satelliteName: 'VIIRS',
    date: '2023-02-02',
  );

  static FireInfoModel tFireInfoInpeModel = const FireInfoModel(
    latitude: -6.409820,
    longitude: -35.093180,
    satelliteName: 'NOAA-20',
    date: '2023-02-01 02:57:00',
  );

  static List filteredNasaCsvLine = [
    'BRA',
    -5.168148,
    -35.218680,
    309.05,
    0.5,
    0.41,
    '2023-02-02',
    329,
    'N',
    'VIIRS',
    'n',
    '2.0NRT',
    292.18,
    1.16,
    'N',
  ];

  static List filteredInpeCsvLine = [
    -6.409820,
    -35.093180,
    'NOAA-20',
    '2023-02-01 02:57:00',
  ];
}
