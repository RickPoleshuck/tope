import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:tope/src/utils/timed_cache.dart';

import 'package:tope/src/utils/vector.dart';

void main() {
  group('Vector', () {
    test('Test timed_cache', () async {
      Vector v1 = Vector(5, 5, 5);
      Vector v2 = Vector(1, 1, 5);
      Vector v3 = Vector(5, 5, 5);
      TimedCache<Vector> tc = TimedCache();
      tc.add(v1);
      tc.add(v2);
      sleep(Duration(seconds: 3));
      tc.add(v3);
      List<Vector> result = tc.find((v) => v.compareMagnitude(v3) < 10);
      print(result);
    });
  });
}