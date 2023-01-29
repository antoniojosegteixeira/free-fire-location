import 'package:equatable/equatable.dart';

class PlacesAutocompleteEntity extends Equatable {
  final String description;
  final String placeId;

  const PlacesAutocompleteEntity({
    required this.description,
    required this.placeId,
  });

  @override
  List<Object?> get props => [
        description,
        placeId,
      ];
}
