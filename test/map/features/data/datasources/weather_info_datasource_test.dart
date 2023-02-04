import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_fire_location/core/env/env.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/core/infra/http_request.dart';
import 'package:free_fire_location/features/map/data/datasources/weather_info_datasource.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture.dart';
import '../../../../test_utils/test_initializer.dart';
import 'weather_info_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HttpRequest>()])
void main() {
  late WeatherInfoDatasource datasourceImpl;
  late final mockHttpRequest = MockHttpRequest();
  const latLng = LatLng(-15.658485, -56.589420);

  setUp(() async {
    await TestInitializer.start();
    datasourceImpl = WeatherInfoDatasourceImpl(client: mockHttpRequest);
  });

  void setUpMockSuccess200() {
    when(
      mockHttpRequest.doRequest(
        endpoint: anyNamed('endpoint'),
        requestMethod: RequestMethod.get,
        body: null,
        headers: anyNamed('headers'),
      ),
    ).thenAnswer((_) async {
      return Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: convert.jsonDecode(fixture('weather_info.json'))
            as Map<String, dynamic>,
      );
    });
  }

  void setUpMockFailure404() {
    when(
      mockHttpRequest.doRequest(
        endpoint: anyNamed('endpoint'),
        requestMethod: anyNamed('requestMethod'),
        body: null,
        headers: anyNamed('headers'),
      ),
    ).thenThrow(
      ServerFailure(),
    );
  }

  void verifyRequest() async {
    verify(
      mockHttpRequest.doRequest(
        endpoint:
            'http://api.weatherapi.com/v1/current.json?key=${Env.weatherKey}&q=${latLng.latitude}%2C${latLng.longitude}',
        requestMethod: RequestMethod.get,
        body: null,
        headers: null,
      ),
    );
  }

  group('Places Info Datasource', () {
    test(
      'should perform a GET request on Places Info URL with correct params',
      () {
        setUpMockSuccess200();

        datasourceImpl.getWeatherByCoordinates(latLng: latLng);

        verifyRequest();
      },
    );

    test(
      'should perform a GET request on  Places Info URL and return a List<PlacesInfoEntity> with matching values',
      () async {
        setUpMockSuccess200();

        final response =
            await datasourceImpl.getWeatherByCoordinates(latLng: latLng);

        verifyRequest();

        expect(response, equals(response));
        // TODO: trocar isso
      },
    );

    test(
      'should perform a failed GET request on  Places Info URL and return a ServerFailure',
      () async {
        setUpMockFailure404();

        dynamic response;

        try {
          response =
              await datasourceImpl.getWeatherByCoordinates(latLng: latLng);
        } catch (err) {
          response = err;
        }

        verifyRequest();
        expect(response, ServerFailure());
      },
    );
  });
}
