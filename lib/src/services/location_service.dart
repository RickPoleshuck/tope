import 'dart:async';
import 'dart:math';

import 'package:location/location.dart';
import 'package:sensors_plus/sensors_plus.dart';

class LocationService {
  static final LocationService _singleton = LocationService._internal();

  factory LocationService() {
    return _singleton;
  }

  LocationService._internal();


}
