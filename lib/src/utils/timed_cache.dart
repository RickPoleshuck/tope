typedef TimedCachePredicate<T> = bool Function(T v);

class _TimedCacheEntry<T> {
  final int _milliSecs;
  final T _value;

  _TimedCacheEntry(this._milliSecs, this._value);

  int get milliSecs => _milliSecs;

  T get value => _value;
}

class TimedCache<T> {
  TimedCache({int timeoutMilliSecs = 2000}) : _timeoutMilliSecs = timeoutMilliSecs;
  final int _timeoutMilliSecs;
  final List<_TimedCacheEntry<T>> _data = [];

  void add(final T value) {
    _removeOld();
    _data.add(_TimedCacheEntry(DateTime.now().millisecondsSinceEpoch, value));
  }

  List<T> find(TimedCachePredicate<T> predicate) {
    _removeOld();
    return _data
        .where(
          (e) => predicate(e.value),
        )
        .map((e) => e.value)
        .toList(growable: false);
  }

  void _removeOld() {
    int now = DateTime.now().millisecondsSinceEpoch;
    _data.removeWhere((e) => e.milliSecs + _timeoutMilliSecs <= now);
  }

  List<T> get all {
    _removeOld();
    return _data.map((e) => e.value).toList(growable: false);
  }
}
