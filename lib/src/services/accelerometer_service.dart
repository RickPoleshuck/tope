import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';
import 'package:tope/src/utils/vector.dart';

class AccelerometerService {
  double _magnitudeThreshold = 2.0;
  double _angleThreshold = 0.2;
  Vector _gyro = Vector(0, 0, 0);
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

  Future<void> _getAccelStream(final StreamController<Vector> output) async {
    userAccelerometerEventStream(samplingPeriod: SensorInterval.normalInterval).listen((UserAccelerometerEvent e) {
      Vector accel = Vector(e.x, e.y, e.z);
      if (accel.magnitude >= _magnitudeThreshold &&
          (gyro.compareDirection(accel) <= _angleThreshold || gyro.compareDirection(-accel) <= _angleThreshold)) {
        output.sink.add(accel);
      }
    }, cancelOnError: true);
  }

  StreamController<Vector> listenAccel() {
    final streamController = StreamController<Vector>();
    _getAccelStream(streamController);
    return streamController;
  }

  Future<void> _getGyroStream(final StreamController<Vector> output) async {
    gyroscopeEventStream(samplingPeriod: const Duration(minutes: 1)).listen((GyroscopeEvent e) {
      _gyro = Vector(e.x, e.y, e.z);
      if (_gyro.magnitude >= _magnitudeThreshold) {
        output.sink.add(_gyro);
      }
    }, cancelOnError: true);
  }

  StreamController<Vector> listenGyro() {
    final streamController = StreamController<Vector>();
    _getGyroStream(streamController);
    return streamController;
  }

  Vector get gyro => _gyro;
}
