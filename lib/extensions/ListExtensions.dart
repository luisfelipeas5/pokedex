extension ListExtensions<T> on List<T> {
  T? get lastOrNull {
    if (isEmpty) {
      return null;
    } else {
      return last;
    }
  }

  T? getOrNull(int index) {
    if (index >= 0 && index < length) {
      return this[index];
    } else {
      return null;
    }
  }
}