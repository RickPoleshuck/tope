import 'dart:collection';

typedef TimedCachePredicate<T> = bool Function(T v);

class TimedCache<T> {
  TimedCache({int timeoutMilliSecs = 2000}) : _timeoutMilliSecs = timeoutMilliSecs;
  final int _timeoutMilliSecs;
  final LinkedHashMap<int, T> _data = LinkedHashMap();

  void add(final T value) {
    _removeOld();
    _data[DateTime.now().millisecondsSinceEpoch] = value;
  }

  List<T> find(TimedCachePredicate<T> predicate) {
    List<T> result = [];
    _removeOld();
    for (MapEntry<int, T> entry in _data.entries) {
      if (predicate(entry.value)) {
        result.add(entry.value);
      }
    }
    return result;
  }

  void _removeOld() {
    int now = DateTime.now().millisecondsSinceEpoch;
    _data.removeWhere((key, value) => key  + _timeoutMilliSecs <= now);
  }
}
