import 'package:free_fire_location/features/map/domain/entities/places_autocomplete_entity.dart';

class PlacesAutocompleteModel extends PlacesAutocompleteEntity {
  const PlacesAutocompleteModel({
    required super.description,
    required super.placeId,
  });

  factory PlacesAutocompleteModel.fromJson(Map<String, dynamic> json) {
    return PlacesAutocompleteModel(
      description: json[('description')],
      placeId: json[('place_id')],
    );
  }
}
