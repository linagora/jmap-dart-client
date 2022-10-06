import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/mdn/mdn.dart';

class MdnConverter {
  MapEntry<Id, Mdn> parseEntry(String key, dynamic value) {
    if(value is Map<String, dynamic>) {
      return MapEntry(Id(key), Mdn.fromJson(value));
    } else {
      return MapEntry(Id(key), value);
    }
  }

  MapEntry<String, dynamic> toJson(Id id, Mdn mdn) {
    return MapEntry(IdConverter().toJson(id), mdn.toJson());
  }
}