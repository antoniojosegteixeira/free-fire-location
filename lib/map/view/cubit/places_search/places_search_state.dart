import 'package:flutter/cupertino.dart';
import 'package:free_fire_location/map/data/response_models/places_search_response.dart';

@immutable
abstract class PlacesSearchState {}

class PlacesSearchResults extends PlacesSearchState {
  List places;

  PlacesSearchResults({required this.places});
}

class PlacesSearchError extends PlacesSearchState {
  final Error error;

  PlacesSearchError({required this.error});
}
