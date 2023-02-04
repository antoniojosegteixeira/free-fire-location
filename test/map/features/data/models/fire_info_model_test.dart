import 'package:flutter_test/flutter_test.dart';
import 'package:free_fire_location/features/map/data/models/fire_info_response.dart';
import 'package:free_fire_location/features/map/domain/entities/fire_info_entity.dart';

import '../../../../test_utils/data_mock.dart';

void main() {
  test('should be subclass of FireInfoEntity', () {
    //assert
    expect(DataMock.tFireInfoNasaModel, isA<FireInfoEntity>());
  });

  group('fromCsv', () {
    test('should return a valid model from Nasa CSV', () async {
      // arrange
      final csvMap = DataMock.filteredNasaCsvLine;
      // act
      final result = FireInfoModel.fromNasaCsv(csvMap);
      // assert
      expect(result, DataMock.tFireInfoNasaModel);
    });

    test('should return a valid model from INPE CSV', () async {
      // arrange
      final csvMap = DataMock.filteredInpeCsvLine;
      // act
      final result = FireInfoModel.fromCsv(csvMap);
      // assert
      expect(result, DataMock.tFireInfoInpeModel);
    });
  });
}
