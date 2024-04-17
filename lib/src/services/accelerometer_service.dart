import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';
import 'package:tope/src/utils/vector.dart';

class AccelerometerService {
  double _threshold = 2.0;
  static final AccelerometerService _singleton = AccelerometerService._internal();

  factory AccelerometerService() {
    return _singleton;
  }

  set threshold(final double value) {
    _threshold = value;
  }

  AccelerometerService._internal();

  Future<void> _getAccelStream(final StreamController<Vector> output) async {
    userAccelerometerEventStream(samplingPeriod: SensorInterval.normalInterval).listen((UserAccelerometerEvent e) {
      Vector accel = Vector(e.x, e.y, e.z);
      if (accel.magnitude >= _threshold) {
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
      Vector accel = Vector(e.x, e.y, e.z);
      if (accel.magnitude >= _threshold) {
        output.sink.add(accel);
      }
    }, cancelOnError: true);
  }

  StreamController<Vector> listenGyro() {
    final streamController = StreamController<Vector>();
    _getGyroStream(streamController);
    return streamController;
  }
}
