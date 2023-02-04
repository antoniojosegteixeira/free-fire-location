import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_fire_location/core/env/env.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/core/infra/http_request.dart';
import 'package:free_fire_location/features/map/data/datasources/places_Info_datasource.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture.dart';
import '../../../../test_utils/data_mock.dart';
import '../../../../test_utils/test_initializer.dart';
import 'places_info_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HttpRequest>()])
void main() {
  late PlacesInfoDatasource datasourceImpl;
  late final mockHttpRequest = MockHttpRequest();
  const String placeId = 'ChIJJWNL5x3GyJQRKsJ4IWo65Rc';

  setUp(() async {
    await TestInitializer.start();
    datasourceImpl = PlacesInfoDatasourceImpl(client: mockHttpRequest);
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
        data: convert.jsonDecode(fixture('places_info.json'))
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
            'https://maps.googleapis.com/maps/api/place/details/json?key=${Env.googleMapsKey}&place_id=$placeId',
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

        datasourceImpl.getPlacesInfo(placeId: placeId);

        verifyRequest();
      },
    );

    test(
      'should perform a GET request on  Places Info URL and return a List<PlacesInfoEntity> with matching values',
      () async {
        setUpMockSuccess200();

        final response = await datasourceImpl.getPlacesInfo(placeId: placeId);

        verifyRequest();

        expect(response, DataMock.tPlacesInfoModel);
      },
    );

    test(
      'should perform a failed GET request on  Places Info URL and return a ServerFailure',
      () async {
        setUpMockFailure404();

        dynamic response;

        try {
          response = await datasourceImpl.getPlacesInfo(placeId: placeId);
        } catch (err) {
          response = err;
        }

        verifyRequest();
        expect(response, ServerFailure());
      },
    );
  });
}
