import 'dart:convert';

import 'package:free_fire_location/map/models/notification_options.dart';

class NotificationOptionsResponse extends NotificationOptions {
  NotificationOptionsResponse({
    required super.range,
    required super.coordinates,
  });

  factory NotificationOptionsResponse.fromJson(Map<String, dynamic> json) =>
      NotificationOptionsResponse(
        range: json["range"],
        coordinates: List<List<double>>.from(json["coordinates"]
            .map((x) => List<double>.from(x.map((x) => x.toDouble())))),
      );

  Map<String, dynamic> toJson() => {
        "range": range,
        "coordinates": List<dynamic>.from(
            coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
