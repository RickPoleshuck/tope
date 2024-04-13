import 'dart:math';

class Vector {
  final double _x;
  final double _y;
  final double _z;
  double? _magnitude; // because the coordinates are immutable, we only have to compute this once.

  Vector(double x, double y, double z)
      : _x = x,
        _y = y,
        _z = z;

  @override
  Vector operator -() {
    return Vector(-_x, -_y, -_z);
  }

  double compareDirection(Vector other) {
    return acos(((_x * other._x) + (_y * other._y) + (_z * other._z)) / (magnitude * other.magnitude));
  }

  double get magnitude {
    _magnitude ??= sqrt((_x * _x) + (_y * _y) + (_z * _z));
    return _magnitude!;
  }

  double compareMagnitude(Vector other) {
    return magnitude - other.magnitude;
  }

  @override
  String toString() {
    return 'Vector{_x: $_x, _y: $_y, _z: $_z}';
  }
}
