import 'dart:convert' as convert;
import 'package:free_fire_location/core/infra/http_request.dart';
import 'package:free_fire_location/core/infra/request_config/places_autocomplete_config.dart';
import 'package:free_fire_location/features/map/data/models/places_autocomplete_model.dart';
import 'package:free_fire_location/features/map/domain/entities/places_autocomplete_entity.dart';

abstract class PlacesAutocompleteDatasource {
  Future<List<PlacesAutocompleteEntity>> getPlacesAutocomplete(
      {required String input});
}

class PlacesAutocompleteDatasourceImpl implements PlacesAutocompleteDatasource {
  PlacesAutocompleteDatasourceImpl({required this.client});

  final HttpRequest client;

  @override
  Future<List<PlacesAutocompleteEntity>> getPlacesAutocomplete(
      {required String input}) async {
    final String requestUrl = PlacesConfig().createRequestUrl(input);

    final response = await client.doRequest(
      endpoint: requestUrl,
      requestMethod: RequestMethod.get,
    );

    Map valueMap = convert.jsonDecode(convert.jsonEncode(response.data));
    Map<String, dynamic> mapped = valueMap as Map<String, dynamic>;
    List predictions = mapped["predictions"];

    final result = predictions
        .map<PlacesAutocompleteEntity>(
          (place) => PlacesAutocompleteModel.fromJson(place),
        )
        .toList();

    return result;
  }
}
