// ignore: depend_on_referenced_packages
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:free_fire_location/features/map/data/models/places_autocomplete_model.dart';
import 'package:free_fire_location/features/map/domain/entities/places_autocomplete_entity.dart';

import '../../../../fixtures/fixture.dart';
import '../../../../test_utils/data_mock.dart';

void main() {
  test('should be subclass of PlacesAutoCompleteEntity', () {
    //assert
    expect(DataMock.tPlacesAutocompleteModel, isA<PlacesAutocompleteEntity>());
  });

  group('fromCsv', () {
    test('should return a valid model from Autocomplete JSON', () async {
      // arrange
      final json = jsonDecode(fixture('places_autocomplete.json'));
      // act
      final result = PlacesAutocompleteModel.fromJson(json['predictions'][0]);
      // assert
      expect(result, DataMock.tPlacesAutocompleteModel);
    });
  });
}
