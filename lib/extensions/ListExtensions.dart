extension ListExtensions<T> on List<T> {
  T? get lastOrNull {
    if (isEmpty) {
      return null;
    } else {
      return last;
    }
  }
}