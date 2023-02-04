import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/core/infra/http_request.dart';
import 'package:free_fire_location/features/map/data/datasources/places_autocomplete_datasource.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture.dart';
import '../../../../test_utils/data_mock.dart';
import '../../../../test_utils/test_initializer.dart';
import 'places_autocomplete_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HttpRequest>()])
void main() {
  late PlacesAutocompleteDatasource datasourceImpl;
  late final mockHttpRequest = MockHttpRequest();

  setUp(() async {
    await TestInitializer.start();
    datasourceImpl = PlacesAutocompleteDatasourceImpl(client: mockHttpRequest);
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
        data: convert.jsonDecode(fixture('places_autocomplete.json'))
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
            'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=Campinas&language=pt_br&types=%28cities%29&key=AIzaSyCQHAhQFwoAyiRw1uIu2MhPOrrT78RO910',
        requestMethod: RequestMethod.get,
        body: null,
        headers: null,
      ),
    );
  }

  group('Places Autocomplete Datasource', () {
    test(
      'should perform a GET request on Places Autocomplete URL with correct params',
      () {
        setUpMockSuccess200();

        datasourceImpl.getPlacesAutocomplete(input: 'Campinas');

        verifyRequest();
      },
    );

    test(
      'should perform a GET request on  Places Autocomplete URL and return a List<PlacesAutocompleteEntity> with matching values',
      () async {
        setUpMockSuccess200();

        final response =
            await datasourceImpl.getPlacesAutocomplete(input: 'Campinas');

        verifyRequest();

        expect(response, DataMock.tPlacesAutocompleteModelList);
      },
    );

    test(
      'should perform a failed GET request on  Places Autocomplete URL and return a ServerFailure',
      () async {
        setUpMockFailure404();

        dynamic response;

        try {
          response =
              await datasourceImpl.getPlacesAutocomplete(input: 'Campinas');
        } catch (err) {
          response = err;
        }

        verifyRequest();
        expect(response, ServerFailure());
      },
    );
  });
}
