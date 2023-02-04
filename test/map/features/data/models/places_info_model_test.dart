// ignore: depend_on_referenced_packages
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:free_fire_location/features/map/data/models/places_info_model.dart';
import 'package:free_fire_location/features/map/domain/entities/places_info_entity.dart';

import '../../../../fixtures/fixture.dart';
import '../../../../test_utils/data_mock.dart';

void main() {
  test('should be subclass of PlacesAutoCompleteEntity', () {
    //assert
    expect(DataMock.tPlacesInfoModel, isA<PlacesInfoEntity>());
  });

  group('fromCsv', () {
    test('should return a valid model from Autocomplete JSON', () async {
      // arrange
      final json = jsonDecode(fixture('places_info.json'));
      // act
      final result =
          PlacesInfoModel.fromJson(json['result']['geometry']['location']);
      // assert
      expect(result, DataMock.tPlacesInfoModel);
    });
  });
}
