import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_fire_location/features/map/data/repositories/weather_info_repository_impl.dart';
import 'package:free_fire_location/features/map/domain/entities/weather_entity.dart';
import 'package:free_fire_location/features/map/domain/usecases/get_weather_info_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_utils/data_mock.dart';
import 'get_weather_info_usecase.mocks.dart';

@GenerateMocks([WeatherInfoRepositoryImpl])
void main() {
  late GetWeatherInfoUsecase useCase;
  final mockRepository = MockWeatherInfoRepositoryImpl();

  setUp(() {
    useCase = GetWeatherInfoUsecase(repository: mockRepository);
  });

  test('Places Info usecase - should get PlacesInfoEntity from the repository',
      () async {
    //arrange
    when(mockRepository.getWeatherByCoordinates(latlng: DataMock.latLng))
        .thenAnswer((_) async => Right(DataMock.tWeatherModel));

    //act
    final result =
        await useCase(const GetWeatherInfoParams(latlng: DataMock.latLng));

    //assert
    verify(mockRepository.getWeatherByCoordinates(latlng: DataMock.latLng));
    expect(
      result,
      Right<dynamic, WeatherEntity>(
        DataMock.tWeatherModel,
      ),
    );
  });
}
