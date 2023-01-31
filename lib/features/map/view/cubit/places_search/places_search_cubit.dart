import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_fire_location/features/map/domain/entities/places_autocomplete_entity.dart';
import 'package:free_fire_location/features/map/domain/entities/places_info_entity.dart';
import 'package:free_fire_location/features/map/domain/usecases/get_places_autocomplete_usecase.dart';
import 'package:free_fire_location/features/map/domain/usecases/get_places_info_usecase.dart';

part 'places_search_state.dart';

class PlacesSearchCubit extends Cubit<PlacesSearchState> {
  PlacesSearchCubit({
    required this.placesAutocompleteUsecase,
    required this.placesInfoUsecase,
  }) : super(const PlacesSearchInitial());

  GetPlacesInfoUsecase placesInfoUsecase;
  GetPlacesAutocompleteUsecase placesAutocompleteUsecase;

  Future<void> getAutoCompletePlaces(String input) async {
    final placesSearchResponse = await placesAutocompleteUsecase.call(
      GetPlacesAutocompleteParams(input: input),
    );

    placesSearchResponse.fold((l) {
      emit.call(const PlacesSearchError());
    }, (r) {
      emit.call(PlacesSearchResults(places: r));
    });
  }

  Future<void> getSearchPlaceLocation(String placeId) async {
    final placeLocationResponse = await placesInfoUsecase.call(
      GetPlacesInfoParams(placeId: placeId),
    );

    placeLocationResponse.fold((l) {
      emit.call(const PlacesSearchError());
    }, (r) {
      emit.call(PlaceInfoLocation(placeInfo: r));
    });
  }

  void setEmptySuggestions() {
    emit.call(const PlacesSearchResults(places: []));
  }
}
