import 'package:flutter_test/flutter_test.dart';
import 'package:free_fire_location/core/error/exceptions.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/features/map/data/datasources/weather_info_datasource.dart';
import 'package:free_fire_location/features/map/data/repositories/weather_info_repository_impl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_utils/data_mock.dart';
import 'weather_info_repository_impl_test.mocks.dart';

@GenerateMocks([WeatherInfoDatasource])
void main() {
  late WeatherInfoRepositoryImpl repository;
  final mockDatasource = MockWeatherInfoDatasource();
  const latLng = LatLng(-15.65622, -56.6251561);

  setUp(() {
    repository = WeatherInfoRepositoryImpl(
      datasource: mockDatasource,
    );
  });

  void setUpMockSuccess() {
    when(mockDatasource.getWeatherByCoordinates(
      latLng: latLng,
    )).thenAnswer((_) async {
      return DataMock.tWeatherModel;
    });
  }

  void setUpMockFailure() {
    when(mockDatasource.getWeatherByCoordinates(latLng: latLng)).thenThrow(
      ServerException(),
    );
  }

  void verifyRequest() {
    verify(mockDatasource.getWeatherByCoordinates(latLng: latLng));
  }

  group('Fire Info Repository', () {
    test(
      'should call the correct datasource function',
      () async {
        // arrange
        setUpMockSuccess();
        // act
        await repository.getWeatherByCoordinates(latlng: latLng);
        // assert
        verifyRequest();
      },
    );

    test(
      'should return FirePageEntity when the request is successful',
      () async {
        // arrange
        setUpMockSuccess();
        // act
        dynamic result;
        final response =
            await repository.getWeatherByCoordinates(latlng: latLng);

        response.fold((l) {
          result = l;
        }, (r) {
          result = r;
        });

        // assert
        verifyRequest();
        expect(
          result,
          equals(DataMock.tWeatherModel),
        );
      },
    );

    test(
      'should return a ServerException when the request fails',
      () async {
        // arrange
        setUpMockFailure();
        // act
        dynamic result;
        final response =
            await repository.getWeatherByCoordinates(latlng: latLng);

        response.fold((l) {
          result = l;
        }, (r) {
          result = r;
        });

        // assert
        verifyRequest();
        expect(
          result,
          equals(ServerFailure()),
        );
      },
    );
  });
}
