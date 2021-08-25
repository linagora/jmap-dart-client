
extension IntegerExtension on num {
  int compareToSort(num value, bool? isAscending) => compareTo(value) * (isAscending == true ? 1 : -1);
}
