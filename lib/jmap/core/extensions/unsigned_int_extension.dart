
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/core/extensions/num_extension.dart';

extension UnsignedIntExtension on UnsignedInt? {
  int compareToSort(UnsignedInt? unsignedInt, bool? isAscending) {
    if (this != null && unsignedInt != null) {
      return this!.value.compareToSort(unsignedInt.value, isAscending);
    }
    return 0;
  }
}
