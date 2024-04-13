import 'package:flutter_test/flutter_test.dart';
import 'package:tope/src/utils/polar.dart';

void main() {
  group('Polar', () {
    test('Test fromCartesian', () {
      Polar p = Polar.fromCartesian(5, 5, 5);
      print(p);
      expect(p.rho.toStringAsFixed(2), '8.66');
      expect(p.phiDeg, 45.0);
      expect(p.thetaDeg.toStringAsFixed(2), '54.74');

      p = Polar.fromCartesian(5, -5, 5);
      print(p);
      expect(p.rho.toStringAsFixed(2), '8.66');
      expect(p.phiDeg, -45.0);
      expect(p.thetaDeg.toStringAsFixed(2), '54.74');

      p = Polar.fromCartesian(-5, 5, 5);
      print(p);
      expect(p.rho.toStringAsFixed(2), '8.66');
      expect(p.phiDeg, -45.0);
      expect(p.thetaDeg.toStringAsFixed(2), '54.74');

      // expect(p.thetaDeg.toStringAsFixed(2), 54.74);
    });
    test('Test negate', () {
      Polar p = Polar.fromCartesian(-5, -5, 0);
      print(p);
      Polar n = Polar.negate(p);
      print(n);
      // expect(1 + 1, 2);
    });
  });
}
