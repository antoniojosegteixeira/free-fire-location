import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_fire_location/features/map/data/models/fire_page_response.dart';
import 'package:free_fire_location/features/map/domain/entities/fire_page_entity.dart';

import '../../../../fixtures/fixture.dart';
import '../../../../test_utils/data_mock.dart';

void main() {
  test('should be subclass of FirePageEntity', () {
    //assert
    expect(DataMock.tFirePageInpeModel, isA<FirePageEntity>());
  });

  group('fromCsv', () {
    test('should return a valid model from Nasa CSV', () async {
      // arrange
      final csv = fixture('nasa_fixture.csv');
      // act
      final result = FirePageModel.fromNasaCsv(csv);
      // assert
      expect(result, DataMock.tFirePageNasaModel);
    });

    test('should return a valid model from INPE CSV', () async {
      // arrange
      final csv = fixture('inpe_fixture.csv');
      // act
      final result = FirePageModel.fromCsvList([csv]);

      // assert
      const DeepCollectionEquality().equals(csv, result);
    });
  });
}
