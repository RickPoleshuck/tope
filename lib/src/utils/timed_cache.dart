import 'dart:collection';

typedef TimedCachePredicate<T> = bool Function(T v);

class TimedCache<T> {
  TimedCache({Duration timeout = const Duration(seconds: 2)});

  final LinkedHashMap<int, T> _data = LinkedHashMap();

  void add(final T value) {
    _removeOld();
    _data[DateTime.now().millisecondsSinceEpoch] = value;
  }

  List<T> find(TimedCachePredicate<T> predicate) {
    List<T> result = [];
    _removeOld();
    int now = DateTime.now().millisecondsSinceEpoch;
    for (MapEntry<int, T> entry in _data.entries) {
      if (entry.key < now) {
        _data.remove(entry.key);
      }
      if (predicate(entry.value)) {
        result.add(entry.value);
      }
    }
    return result;
  }

  void _removeOld() {
    int now = DateTime.now().millisecondsSinceEpoch;
    for (MapEntry<int, T> entry in _data.entries) {
      if (entry.key < now) {
        _data.remove(entry.key);
      } else {
        break;
      }
    }
  }
}
