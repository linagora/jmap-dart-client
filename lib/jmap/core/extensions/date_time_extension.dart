
extension DateTimeExtension on DateTime {
  int compareToSort(DateTime value, bool isAscending) => compareTo(value) * (isAscending ? 1 : -1);
}
