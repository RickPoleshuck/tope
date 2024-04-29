import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';
import 'package:tope/src/utils/timed_cache.dart';
import 'package:tope/src/utils/vector.dart';

class AccelerometerService {
  double _magnitudeThreshold = 2.0;
  double _angleThreshold = 0.5;
  Vector _lastUserAccel = Vector(0, 0, 0);
  Vector _lastAccel = Vector(0, 0, 0);
  TimedCache<Vector> _ups = TimedCache();
  static final AccelerometerService _singleton = AccelerometerService._internal();

  factory AccelerometerService() {
    return _singleton;
  }

  set magnitudeThreshold(final double value) {
    _magnitudeThreshold = value;
  }

  set angleThreshold(final double value) {
    _angleThreshold = value;
  }

  AccelerometerService._internal();

  Future<void> _getUserAccelStream(final StreamController<Vector> output) async {
    userAccelerometerEventStream(samplingPeriod: SensorInterval.normalInterval).listen((UserAccelerometerEvent e) {
      _lastUserAccel = Vector(e.x, e.y, e.z);
      if (_lastUserAccel.magnitude >= _magnitudeThreshold &&
          _lastAccel.compareDirection(-_lastUserAccel) <= _angleThreshold) {
        _ups.add(_lastAccel);
      } else if (_lastUserAccel.magnitude >= _magnitudeThreshold &&
          _ups.find((v) => _lastUserAccel.compareDirection(v) <= _angleThreshold).length > 0) {
        output.sink.add(_lastUserAccel);
      }
    }, cancelOnError: true);
  }

  StreamController<Vector> listenUserAccel() {
    final streamController = StreamController<Vector>();
    _getUserAccelStream(streamController);
    return streamController;
  }

  Future<void> _getAccelUp(final StreamController<Vector> output) async {
    accelerometerEventStream(
      samplingPeriod: const Duration(milliseconds: 20000),
    ).listen((AccelerometerEvent e) {
      _lastAccel = Vector(e.x, e.y, e.z);
      Vector up = _lastUserAccel - _lastAccel;
      output.sink.add(up);
    }, cancelOnError: true);
  }

  StreamController<Vector> listenUp() {
    final streamController = StreamController<Vector>();
    _getAccelUp(streamController);
    return streamController;
  }
}
