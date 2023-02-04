import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_fire_location/features/map/data/repositories/fire_info_repository_impl.dart';
import 'package:free_fire_location/features/map/domain/entities/fire_page_entity.dart';
import 'package:free_fire_location/features/map/domain/usecases/get_fire_info_inpe_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_utils/data_mock.dart';
import 'get_fire_info_inpe_usecase_test.mocks.dart';

@GenerateMocks([FireInfoRepositoryImpl])
void main() {
  late GetFireInfoInpeUsecase useCase;
  final mockRepository = MockFireInfoRepositoryImpl();

  setUp(() {
    useCase = GetFireInfoInpeUsecase(repository: mockRepository);
  });

  test('INPE Usecase - should get FirePageEntity from the repository',
      () async {
    //arrange
    when(
      mockRepository.getFireLocationsInpe(amount: 10),
    ).thenAnswer((_) async => Right(DataMock.tFirePageInpeModel));

    //act
    final result = await useCase(
      const GetFireInfoInpeParams(
        amount: 10,
      ),
    );

    //assert
    verify(mockRepository.getFireLocationsInpe(amount: 10));
    expect(
      result,
      Right<dynamic, FirePageEntity>(
        DataMock.tFirePageInpeModel,
      ),
    );
  });
}
