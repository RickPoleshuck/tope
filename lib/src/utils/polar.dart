import 'dart:math';

class Polar {
  final double _rho;
  final double _theta; // x y angle -180 to +180
  final double _phi; // z angle -90 to +90
  Polar(double rho, double theta, double phi)
      : _rho = rho,
        _theta = theta,
        _phi = phi;

  Polar.fromCartesian(double x, double y, double z)
      : _rho = sqrt((x * x) + (y * y) + (z * z)),
        _theta = atan2(y, x),
        _phi = sqrt((x * x) + (y * y)) / z;

  @override
  String toString() {
    return 'rho: $_rho, theta: $_theta, phi: $_phi, theta_deg: $thetaDeg, phi_deg: $phiDeg';
  }

  Polar.negate(Polar p)
      : _rho = -p._rho,
        _theta = p._theta,
        _phi = -p._phi + pi;

  /// return absolute value of angle difference
  double compareAngle(final Polar p1, final Polar p2) {
    return max((p1._phi - p2._phi).abs(), (p1._theta - p2._theta).abs());
  }

  double get phi => _phi;

  double get theta => _theta;

  double get thetaDeg => rad2deg(_theta);
  double get phiDeg => rad2deg(_phi);

  double get rho => _rho;
  static double rad2deg(double radians ){
    return radians * (180 / pi);
  }
}
