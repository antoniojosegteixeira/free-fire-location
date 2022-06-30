class FilterMarkers {
  static const double southernMostLat = -33.773627;
  static const double northernMostLat = 5.289509;
  static const double westernMostLon = -73.987019;
  static const double easternMostLon = -3.806376;

  static bool isFireLocatedInBrazil(
      {required double lat, required double lon}) {
    final bool isInsideLat = lat > southernMostLat && lat < northernMostLat;
    final bool isInsideLon = lon > westernMostLon && lon < easternMostLon;

    if (isInsideLon == true && isInsideLat == true) {
      return true;
    } else {
      return false;
    }
  }
}
