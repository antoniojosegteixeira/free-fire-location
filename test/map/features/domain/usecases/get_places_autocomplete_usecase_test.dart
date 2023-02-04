import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_fire_location/features/map/data/repositories/places_repository_impl.dart';
import 'package:free_fire_location/features/map/domain/entities/places_autocomplete_entity.dart';
import 'package:free_fire_location/features/map/domain/usecases/get_places_autocomplete_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_utils/data_mock.dart';
import 'get_places_autocomplete_usecase_test.mocks.dart';

@GenerateMocks([PlacesRepositoryImpl])
void main() {
  late GetPlacesAutocompleteUsecase useCase;
  final mockRepository = MockPlacesRepositoryImpl();

  setUp(() {
    useCase = GetPlacesAutocompleteUsecase(repository: mockRepository);
  });

  test(
      'Places Autocomplete usecase - should get FirePageEntity from the repository',
      () async {
    //arrange
    when(mockRepository.getAutocompleteInfo(input: 'Campinas'))
        .thenAnswer((_) async => Right([DataMock.tPlacesAutocompleteModel]));

    //act
    final result = await useCase(
      const GetPlacesAutocompleteParams(input: 'Campinas'),
    );

    //assert
    verify(mockRepository.getAutocompleteInfo(input: 'Campinas'));
    expect(
      result,
      Right<dynamic, List<PlacesAutocompleteEntity>>(
        [DataMock.tPlacesAutocompleteModel],
      ),
    );
  });
}
