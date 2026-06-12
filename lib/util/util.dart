Iterable<int> get positiveIntegers sync* {
  int i = 0;
  while (true) {
    yield i++;
  }
}

int? parseIntNullable(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  if (v is String) return int.tryParse(v);
  return null;
}

List<int>? parseIntListNullable(dynamic v) {
  if (v == null) return null;
  if (v is List) return v.map((e) => parseIntNullable(e)).whereType<int>().toList();
  return null;
}

bool? parseBoolNullable(dynamic v) {
  if (v == null) return null;
  if (v is bool) return v;
  if (v is String) {
    if (v == 'true') return true;
    if (v == 'false') return false;
  }
  return null;
}
