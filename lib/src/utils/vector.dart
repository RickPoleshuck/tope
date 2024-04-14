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

  Vector operator -() {
    return Vector(-_x, -_y, -_z);
  }

  Vector.up()
      : _x = 0,
        _y = 0,
        _z = 9.8;

  Vector operator -(Vector other) {
    return Vector(_x - other._x, _y - other._y, _z - other._z);
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

  String display() {
    return '${_x.toStringAsFixed(2)}, ${_y.toStringAsFixed(2)}, ${_z.toStringAsFixed(2)}';
  }
}
