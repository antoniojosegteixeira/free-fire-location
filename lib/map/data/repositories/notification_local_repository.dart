import 'dart:convert';

import 'package:free_fire_location/map/data/response_models/notification_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationLocalRepository {
  Future<void> cacheNotificationOptions(
      {required NotificationOptionsResponse optionsToCache}) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(
      'CACHED_NOTIFICATION_OPTIONS',
      jsonEncode(optionsToCache.toJson()),
    );
  }

  Future<NotificationOptionsResponse> getcachedNotificationOptions() async {
    final prefs = await SharedPreferences.getInstance();

    final String cacheString =
        prefs.getString('CACHED_NOTIFICATION_OPTIONS') as String;

    return NotificationOptionsResponse.fromJson(json.decode(cacheString));
  }
}
