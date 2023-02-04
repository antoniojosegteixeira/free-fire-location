import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_fire_location/core/error/failures.dart';
import 'package:free_fire_location/core/infra/http_request.dart';
import 'package:free_fire_location/features/map/data/datasources/fire_info_datasource_nasa.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture.dart';
import '../../../../test_utils/data_mock.dart';
import '../../../../test_utils/test_initializer.dart';
import 'fire_info_datasource_nasa_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HttpRequest>()])
void main() {
  late FireInfoDatasourceNasa datasourceImpl;
  late final mockHttpRequest = MockHttpRequest();

  setUp(() async {
    await TestInitializer.start();
    datasourceImpl = FireInfoDatasourceNasa(client: mockHttpRequest);
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
        data: fixture('nasa_fixture.csv'),
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

  Future<void> verifyRequest() async {
    verify(
          mockHttpRequest.doRequest(
            endpoint: anyNamed('endpoint'),
            requestMethod: RequestMethod.get,
            body: null,
            headers: anyNamed('headers'),
          ),
        ).callCount ==
        10;
  }

  group('Nasa Fires Datasource', () {
    test(
      'should perform a GET request on Nasa URL with correct params',
      () {
        setUpMockSuccess200();

        datasourceImpl.getFireLocations(
          amount: 10,
        );

        verifyRequest();
      },
    );

    test(
      'should perform a GET request on Nasa URL and return a FirePageModel with matching values',
      () async {
        setUpMockSuccess200();

        final response = await datasourceImpl.getFireLocations(amount: 1);

        await verifyRequest();

        expect(response, DataMock.tFirePageNasaModel);
      },
    );

    test(
      'should perform a failed GET request on Nasa URL and return a ServerFailure',
      () async {
        setUpMockFailure404();

        dynamic response;

        try {
          response = await datasourceImpl.getFireLocations(amount: 1);
        } catch (err) {
          response = err;
        }

        await verifyRequest();
        expect(response, ServerFailure());
      },
    );
  });
}
