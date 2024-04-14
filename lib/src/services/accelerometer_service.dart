import 'dart:async';
import 'dart:math';

import 'package:sensors_plus/sensors_plus.dart';
import 'package:tope/src/utils/vector.dart';

class AccelerometerService {
  double _threshold = 2.0;
  Vector? _up;
  static final AccelerometerService _singleton = AccelerometerService._internal();

  factory AccelerometerService() {
    return _singleton;
  }

  set threshold(final double value) {
    _threshold = value;
  }

  AccelerometerService._internal();

  Future<void> _listen(final StreamController<double> output) async {
    _up ??= await upVector();
    userAccelerometerEventStream(samplingPeriod: SensorInterval.normalInterval).listen((UserAccelerometerEvent e) {
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

  double _getAcceleration(UserAccelerometerEvent e) {
    return Vector(e.x, e.y, e.z).magnitude;
  }

  Future<void> _getRawStream(final StreamController<Vector> output) async {
    accelerometerEventStream(samplingPeriod: const Duration(seconds: 1)).listen((AccelerometerEvent e) {
      output.sink.add(Vector(e.x, e.y, e.z));
    });
  }

  Future<Vector> _getRaw() async {
    final streamController = StreamController<Vector>();
    _getRawStream(streamController);
    Vector result = await streamController.stream.first;
    streamController.close();
    return result;
  }

  Future<Vector> upVector() async {
    Vector raw = await _getRaw();
    return raw - Vector.up();
  }
}
