import 'package:location/location.dart';
class Bump {
  final double _acceleration;
  final Location _location;

  Bump(this._acceleration, this._location);

  double get acceleration => _acceleration;
}