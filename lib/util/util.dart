Iterable<int> get positiveIntegers sync* {
  int i = 0;
  while (true) {
    yield i++;
  }
}