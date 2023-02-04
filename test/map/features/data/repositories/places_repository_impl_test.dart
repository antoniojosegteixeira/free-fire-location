import 'package:flutter_test/flutter_test.dart';
import 'package:free_fire_location/core/error/exceptions.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/features/map/data/datasources/places_autocomplete_datasource.dart';
import 'package:free_fire_location/features/map/data/datasources/places_info_datasource.dart';
import 'package:free_fire_location/features/map/data/repositories/places_repository_impl.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_utils/data_mock.dart';
import 'places_repository_impl_test.mocks.dart';

@GenerateMocks([PlacesInfoDatasourceImpl, PlacesAutocompleteDatasourceImpl])
void main() {
  late PlacesRepositoryImpl repository;
  final mockDatasourceInfo = MockPlacesInfoDatasourceImpl();
  final mockDatasourceAutocomplete = MockPlacesAutocompleteDatasourceImpl();
  const String placeId = 'uUmaXx92nOkmsd';

  setUp(() {
    repository = PlacesRepositoryImpl(
      datasourceInfo: mockDatasourceInfo,
      datasourceAutocomplete: mockDatasourceAutocomplete,
    );
  });

  void setUpMockInfoSuccess() {
    when(
      mockDatasourceInfo.getPlacesInfo(placeId: placeId),
    ).thenAnswer((_) async {
      return DataMock.tPlacesInfoModel;
    });
  }

  void setUpMockInfoFailure() {
    when(
      mockDatasourceInfo.getPlacesInfo(placeId: placeId),
    ).thenThrow(
      ServerException(),
    );
  }

  void verifyInfoRequest() {
    verify(
      mockDatasourceInfo.getPlacesInfo(placeId: placeId),
    );
  }

  void setUpMockAutocompleteSuccess() {
    when(
      mockDatasourceAutocomplete.getPlacesAutocomplete(input: 'Campinas'),
    ).thenAnswer((_) async {
      return [DataMock.tPlacesAutocompleteModel];
    });
  }

  void setUpMockAutocompleteFailure() {
    when(mockDatasourceAutocomplete.getPlacesAutocomplete(input: 'Campinas'))
        .thenThrow(
      ServerException(),
    );
  }

  void verifyAutocompleteRequest() {
    verify(mockDatasourceAutocomplete.getPlacesAutocomplete(input: 'Campinas'));
  }

  group('Places Autocomplete Repository', () {
    test(
      'should call the correct autocomplete datasource function',
      () async {
        // arrange
        setUpMockAutocompleteSuccess();
        // act
        await repository.getAutocompleteInfo(input: 'Campinas');
        // assert
        verifyAutocompleteRequest();
      },
    );

    test(
      'should return a list of PlacesAutocompleteEntity when the request is successful',
      () async {
        // arrange
        setUpMockAutocompleteSuccess();
        // act
        dynamic result;
        final response =
            await repository.getAutocompleteInfo(input: 'Campinas');

        response.fold((l) {
          result = l;
        }, (r) {
          result = r;
        });

        // assert
        verifyAutocompleteRequest();
        expect(result, [DataMock.tPlacesAutocompleteModel]);
      },
    );

    test(
      'should return a ServerException when the request fails',
      () async {
        // arrange
        setUpMockAutocompleteFailure();
        // act
        dynamic result;
        final response =
            await repository.getAutocompleteInfo(input: 'Campinas');

        response.fold((l) {
          result = l;
        }, (r) {
          result = r;
        });

        // assert
        verifyAutocompleteRequest();
        expect(
          result,
          equals(
            ServerFailure(),
          ),
        );
      },
    );
  });
  group('Places Info Repository', () {
    test(
      'should call the correct Info datasource function',
      () async {
        // arrange
        setUpMockInfoSuccess();
        // act
        await repository.getPlacesInfo(placeId: placeId);

        // assert
        verifyInfoRequest();
      },
    );

    test(
      'should return a list of PlacesInfoEntity when the request is successful',
      () async {
        // arrange
        setUpMockInfoSuccess();
        // act
        dynamic result;
        final response = await repository.getPlacesInfo(placeId: placeId);

        response.fold((l) {
          result = l;
        }, (r) {
          result = r;
        });
        // assert
        verifyInfoRequest();
        expect(
          result,
          equals(
            DataMock.tPlacesInfoModel,
          ),
        );
      },
    );

    test(
      'should return a ServerException when the request fails',
      () async {
        // arrange
        setUpMockInfoFailure();
        // act
        dynamic result;
        final response = await repository.getPlacesInfo(placeId: placeId);

        response.fold((l) {
          result = l;
        }, (r) {
          result = r;
        });
        // assert
        verifyInfoRequest();
        expect(
          result,
          equals(
            ServerFailure(),
          ),
        );
      },
    );
  });
}
