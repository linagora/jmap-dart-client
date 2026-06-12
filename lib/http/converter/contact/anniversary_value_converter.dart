import 'package:jmap_dart_client/jmap/contact/contact_id.dart';
import 'package:jmap_dart_client/jmap/contact/anniversary_value.dart';
import 'anniversary_id_converter.dart';

class AnniversaryValueConverter {
  MapEntry<AnniversaryId, AnniversaryValue> parseEntry(String key, dynamic value) {
    if (value is Map<String, dynamic>) {
      return MapEntry(AnniversaryId(key), AnniversaryValue.fromJson(value));
    } else {
      return MapEntry(AnniversaryId(key), value);
    }
  }

  MapEntry<String, dynamic> toJson(AnniversaryId anniversaryId, AnniversaryValue value) {
    return MapEntry(const AnniversaryIdConverter().toJson(anniversaryId), value.toJson());
  }
}
