import 'package:free_fire_location/map/models/places_search.dart';

class PlacesSearchResponse extends PlacesSearch {
  PlacesSearchResponse({
    required super.description,
    required super.placeId,
  });

  factory PlacesSearchResponse.fromJson(Map<String, dynamic> json) {
    return PlacesSearchResponse(
      description: json[('description')],
      placeId: json[('place_id')],
    );
  }
}
