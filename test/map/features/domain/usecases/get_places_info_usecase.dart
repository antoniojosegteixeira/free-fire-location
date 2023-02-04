import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_fire_location/features/map/data/repositories/places_repository_impl.dart';
import 'package:free_fire_location/features/map/domain/entities/places_info_entity.dart';
import 'package:free_fire_location/features/map/domain/usecases/get_places_info_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_utils/data_mock.dart';
import 'get_places_info_usecase.mocks.dart';

@GenerateMocks([PlacesRepositoryImpl])
void main() {
  late GetPlacesInfoUsecase useCase;
  final mockRepository = MockPlacesRepositoryImpl();

  setUp(() {
    useCase = GetPlacesInfoUsecase(repository: mockRepository);
  });

  test('Places Info usecase - should get PlacesInfoEntity from the repository',
      () async {
    //arrange
    when(mockRepository.getPlacesInfo(placeId: DataMock.placeId))
        .thenAnswer((_) async => Right(DataMock.tPlacesInfoModel));

    //act
    final result = await useCase(
      const GetPlacesInfoParams(placeId: DataMock.placeId),
    );

    //assert
    verify(mockRepository.getPlacesInfo(placeId: DataMock.placeId));
    expect(
      result,
      Right<dynamic, PlacesInfoEntity>(
        DataMock.tPlacesInfoModel,
      ),
    );
  });
}
