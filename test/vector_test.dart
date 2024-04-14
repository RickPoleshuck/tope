import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:tope/src/utils/vector.dart';

void main() {
  group('Vector', () {
    test('Test comaparison', () {
      Vector v1 = Vector(5, 5, 5);
      print('v1=$v1, v1.mag=${v1.magnitude}');
      Vector v2 = Vector(-5, -4, -5);
      print('v2=$v2, v2.mag=${v2.magnitude}');
      double diff = v1.compareDirection(-v2);
      print('diff Rad: $diff, diff deg: ${diff * (180/pi) }');
      diff = v1.compareDirection(v1);
      print('diff Rad: $diff, diff deg: ${diff * (180/pi) }');
      diff = v1.compareDirection(-v1);
      print('diff Rad: $diff, diff deg: ${diff * (180/pi) }');

      Vector v3 = v1 - v2;
      print(v3);
    });
  });
}
