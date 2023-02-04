// ignore: depend_on_referenced_packages
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:free_fire_location/features/map/data/models/weather_model.dart';
import 'package:free_fire_location/features/map/domain/entities/weather_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../fixtures/fixture.dart';
import '../../../../test_utils/data_mock.dart';

void main() {
  test('should be subclass of PlacesAutoCompleteEntity', () {
    //assert
    expect(DataMock.tWeatherModel, isA<WeatherEntity>());
  });

  group('fromCsv', () {
    test('should return a valid model from Weather JSON', () async {
      // arrange
      final json = jsonDecode(fixture('weather_info.json'));
      // act
      final result = WeatherModel.fromJson(json, const LatLng(-15, -56));
      // assert
      expect(result, DataMock.tWeatherModel);
    });
  });
}
