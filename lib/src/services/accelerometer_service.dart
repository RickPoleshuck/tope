import 'dart:async';
import 'dart:math';

import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerService {
  double _threshold = 2.0;
  static final AccelerometerService _singleton =
      AccelerometerService._internal();

  factory AccelerometerService() {
    return _singleton;
  }

  set threshold(final double value) {
    _threshold = value;
  }

  AccelerometerService._internal();

  Future<void> _listen(final StreamController<double> output) async {
    userAccelerometerEventStream(samplingPeriod: SensorInterval.normalInterval)
        .listen((UserAccelerometerEvent e) {
      final double acceleration = _getAcceleration(e);
      if (acceleration >= _threshold) {
        output.sink.add(acceleration);
      }
    }, cancelOnError: true);
  }

  StreamController<double> listen() {
    final streamController = StreamController<double>();
    _listen(streamController);
    return streamController;
  }

  /// Return maximum acceleration from all 3 directions.
  double _getAcceleration(UserAccelerometerEvent e) {
    return sqrt((e.x * e.x) + (e.y * e.y) + (e.z * e.z));
  }
}
