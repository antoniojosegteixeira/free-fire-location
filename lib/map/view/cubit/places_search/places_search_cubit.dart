import 'package:bloc/bloc.dart';
import 'package:free_fire_location/map/data/repositories/places_search_repository.dart';
import 'package:free_fire_location/map/data/response_models/places_search_response.dart';
import 'package:free_fire_location/map/view/cubit/places_search/places_search_state.dart';

class PlacesSearchCubit extends Cubit<PlacesSearchState> {
  final PlacesSearchRepository _placesSearchRepository =
      PlacesSearchRepository();
  PlacesSearchCubit() : super(PlacesSearchInitial());

  Future<void> getAutoCompletePlaces(String input) async {
    try {
      final Future<List> placesSearchResponse =
          _placesSearchRepository.getAutoCompletePlaces(input);

      emit.call(PlacesSearchResults(places: placesSearchResponse));
    } catch (e) {
      emit.call(PlacesSearchError(error: e as Error));
    }
  }
}
