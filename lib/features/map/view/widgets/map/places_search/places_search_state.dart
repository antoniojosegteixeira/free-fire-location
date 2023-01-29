part of 'places_search_cubit.dart';

abstract class PlacesSearchState extends Equatable {
  const PlacesSearchState({required this.places});

  final List<PlacesAutocompleteEntity> places;
  @override
  List<Object> get props => [places];
}

class PlacesSearchInitial extends PlacesSearchState {
  const PlacesSearchInitial({super.places = const []});
}

class PlacesSearchResults extends PlacesSearchState {
  const PlacesSearchResults({required super.places});
}

class PlacesSearchError extends PlacesSearchState {
  const PlacesSearchError({super.places = const []});
}
