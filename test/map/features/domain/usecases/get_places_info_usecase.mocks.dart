// Mocks generated by Mockito 5.3.2 from annotations
// in free_fire_location/test/map/features/domain/usecases/get_places_info_usecase.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i4;
import 'package:free_fire_location/core/error/failures.dart' as _i7;
import 'package:free_fire_location/features/map/data/datasources/places_autocomplete_datasource.dart'
    as _i3;
import 'package:free_fire_location/features/map/data/datasources/places_info_datasource.dart'
    as _i2;
import 'package:free_fire_location/features/map/data/repositories/places_repository_impl.dart'
    as _i5;
import 'package:free_fire_location/features/map/domain/entities/places_autocomplete_entity.dart'
    as _i9;
import 'package:free_fire_location/features/map/domain/entities/places_info_entity.dart'
    as _i8;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePlacesInfoDatasource_0 extends _i1.SmartFake
    implements _i2.PlacesInfoDatasource {
  _FakePlacesInfoDatasource_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePlacesAutocompleteDatasource_1 extends _i1.SmartFake
    implements _i3.PlacesAutocompleteDatasource {
  _FakePlacesAutocompleteDatasource_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_2<L, R> extends _i1.SmartFake implements _i4.Either<L, R> {
  _FakeEither_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [PlacesRepositoryImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockPlacesRepositoryImpl extends _i1.Mock
    implements _i5.PlacesRepositoryImpl {
  MockPlacesRepositoryImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.PlacesInfoDatasource get datasourceInfo => (super.noSuchMethod(
        Invocation.getter(#datasourceInfo),
        returnValue: _FakePlacesInfoDatasource_0(
          this,
          Invocation.getter(#datasourceInfo),
        ),
      ) as _i2.PlacesInfoDatasource);
  @override
  _i3.PlacesAutocompleteDatasource get datasourceAutocomplete =>
      (super.noSuchMethod(
        Invocation.getter(#datasourceAutocomplete),
        returnValue: _FakePlacesAutocompleteDatasource_1(
          this,
          Invocation.getter(#datasourceAutocomplete),
        ),
      ) as _i3.PlacesAutocompleteDatasource);
  @override
  _i6.Future<_i4.Either<_i7.Failure, _i8.PlacesInfoEntity>> getPlacesInfo(
          {required String? placeId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPlacesInfo,
          [],
          {#placeId: placeId},
        ),
        returnValue:
            _i6.Future<_i4.Either<_i7.Failure, _i8.PlacesInfoEntity>>.value(
                _FakeEither_2<_i7.Failure, _i8.PlacesInfoEntity>(
          this,
          Invocation.method(
            #getPlacesInfo,
            [],
            {#placeId: placeId},
          ),
        )),
      ) as _i6.Future<_i4.Either<_i7.Failure, _i8.PlacesInfoEntity>>);
  @override
  _i6.Future<_i4.Either<_i7.Failure, List<_i9.PlacesAutocompleteEntity>>>
      getAutocompleteInfo({required String? input}) => (super.noSuchMethod(
            Invocation.method(
              #getAutocompleteInfo,
              [],
              {#input: input},
            ),
            returnValue: _i6.Future<
                    _i4.Either<_i7.Failure,
                        List<_i9.PlacesAutocompleteEntity>>>.value(
                _FakeEither_2<_i7.Failure, List<_i9.PlacesAutocompleteEntity>>(
              this,
              Invocation.method(
                #getAutocompleteInfo,
                [],
                {#input: input},
              ),
            )),
          ) as _i6.Future<
              _i4.Either<_i7.Failure, List<_i9.PlacesAutocompleteEntity>>>);
}
