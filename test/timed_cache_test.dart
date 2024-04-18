import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tope/src/utils/timed_cache.dart';
import 'package:tope/src/utils/vector.dart';

void main() {
  group('Vector', () {
    test('Test timed_cache', () async {
      Vector v1 = Vector(5, 5, 5);
      Vector v2 = Vector(1, 1, 5);
      Vector v3 = Vector(5, 6, 5);
      Vector v4 = Vector(5, 6, 5);
      Vector v5 = Vector(5, 6, 5);
      TimedCache<Vector> tc = TimedCache();
      tc.add(v1);
      tc.add(v2);
      sleep(Duration(seconds: 3));
      tc.add(v3);
      tc.add(v4);
      print(tc.all);
      List<Vector> result = tc.find(
        (v) => v.compareMagnitude(v5) < 100,
      );
      print(result);
    });
  });
}
