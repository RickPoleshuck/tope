import 'package:flutter_test/flutter_test.dart';
import 'package:tope/src/utils/polar.dart';

void main() {
  group('Polar', () {
    test('Test negate', () {
      Polar p = Polar.fromCartesian(5, -5,5);
      print(p);
      Polar n = Polar.negate(p);
      print(n);
      // expect(1 + 1, 2);
    });
  });
}
