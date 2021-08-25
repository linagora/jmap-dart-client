
extension StringExtension on String? {
  int compareToSort(String? value, bool? isAscending) {
    if (this != null && value != null) {
      return this!.toLowerCase().compareTo(value.toLowerCase()) * (isAscending == true ? 1 : -1);
    }
    return 0;
  }
}
