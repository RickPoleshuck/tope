

class LocationService {
  static final LocationService _singleton = LocationService._internal();

  factory LocationService() {
    return _singleton;
  }

  LocationService._internal();
}
