import 'package:flutter_test/flutter_test.dart';
import 'package:free_fire_location/core/error/exceptions.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/features/map/data/datasources/fire_info_datasource_inpe.dart';
import 'package:free_fire_location/features/map/data/datasources/fire_info_datasource_nasa.dart';
import 'package:free_fire_location/features/map/data/models/fire_page_response.dart';
import 'package:free_fire_location/features/map/data/repositories/fire_info_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_utils/data_mock.dart';
import 'fire_info_repository_impl_test.mocks.dart';

@GenerateMocks([FireInfoDatasourceInpe, FireInfoDatasourceNasa])
void main() {
  late FireInfoRepositoryImpl repository;
  final mockDatasourceInpe = MockFireInfoDatasourceInpe();
  final mockDatasourceNasa = MockFireInfoDatasourceNasa();

  setUp(() {
    repository = FireInfoRepositoryImpl(
      datasourceInpe: mockDatasourceInpe,
      datasourceNasa: mockDatasourceNasa,
    );
  });

  void setUpMockInpeSuccess() {
    when(
      mockDatasourceInpe.getFireLocations(amount: 10),
    ).thenAnswer((_) async {
      return DataMock.tFirePageInpeModel as FirePageModel;
    });
  }

  void setUpMockInpeFailure() {
    when(
      mockDatasourceInpe.getFireLocations(amount: 10),
    ).thenThrow(
      ServerException(),
    );
  }

  void verifyInpeRequest() {
    verify(mockDatasourceInpe.getFireLocations(amount: 10));
  }

  group('Fire Info Repository', () {
    test(
      'should call the correct datasource function',
      () async {
        // arrange
        setUpMockInpeSuccess();
        // act
        await repository.getFireLocationsInpe(amount: 10);
        // assert
        verifyInpeRequest();
      },
    );

    test(
      'should return FirePageEntity when the request is successful',
      () async {
        // arrange
        setUpMockInpeSuccess();
        // act
        dynamic result;
        final response = await repository.getFireLocationsInpe(amount: 10);

        response.fold((l) {
          result = l;
        }, (r) {
          result = r;
        });

        // assert
        verifyInpeRequest();
        expect(
          result,
          equals(
            DataMock.tFirePageInpeModel,
          ),
        );
      },
    );

    test(
      'should return a ServerException when the request fails',
      () async {
        // arrange
        setUpMockInpeFailure();
        // act
        dynamic result;
        final response = await repository.getFireLocationsInpe(amount: 10);

        response.fold((l) {
          result = l;
        }, (r) {
          result = r;
        });

        // assert
        verifyInpeRequest();
        expect(
          result,
          equals(ServerFailure()),
        );
      },
    );
  });
}
