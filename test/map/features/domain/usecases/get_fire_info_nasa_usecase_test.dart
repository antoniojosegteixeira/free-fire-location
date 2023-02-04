import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_fire_location/features/map/data/repositories/fire_info_repository_impl.dart';
import 'package:free_fire_location/features/map/domain/entities/fire_page_entity.dart';
import 'package:free_fire_location/features/map/domain/usecases/get_fire_info_nasa_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_utils/data_mock.dart';
import 'get_fire_info_nasa_usecase_test.mocks.dart';

@GenerateMocks([FireInfoRepositoryImpl])
void main() {
  late GetFireInfoNasaUsecase useCase;
  final mockRepository = MockFireInfoRepositoryImpl();

  setUp(() {
    useCase = GetFireInfoNasaUsecase(repository: mockRepository);
  });

  test('Nasa usecase - should get FirePageEntity from the repository',
      () async {
    //arrange
    when(
      mockRepository.getFireLocationsInpe(amount: 10),
    ).thenAnswer((_) async => Right(DataMock.tFirePageNasaModel));

    //act
    final result = await useCase(
      const GetFireInfoNasaParams(
        amount: 10,
      ),
    );

    //assert
    verify(mockRepository.getFireLocationsInpe(amount: 10));
    expect(
      result,
      Right<dynamic, FirePageEntity>(
        DataMock.tFirePageNasaModel,
      ),
    );
  });
}
