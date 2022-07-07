import 'dart:convert';

import 'package:free_fire_location/map/models/notification_options.dart';

class NotificationOptionsResponse extends NotificationOptions {
  NotificationOptionsResponse({
    required super.range,
  });

  factory NotificationOptionsResponse.fromJson(Map<String, dynamic> json) =>
      NotificationOptionsResponse(
        range: json["range"],
      );

  Map<String, dynamic> toJson() => {
        "range": range,
      };
}
