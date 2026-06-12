import 'package:jmap_dart_client/http/converter/contact/related_to_name_converter.dart';
import 'package:jmap_dart_client/jmap/contact/contact_id.dart';
import 'package:jmap_dart_client/jmap/contact/related_to_value.dart';


class RelatedToValueConverter {
  MapEntry<RelatedToName, RelatedToValue> parseEntry(String key, dynamic value) {
    if (value is Map<String, dynamic>) {
      return MapEntry(RelatedToName(key), RelatedToValue.fromJson(value));
    } else {
      return MapEntry(RelatedToName(key), value);
    }
  }

  MapEntry<String, dynamic> toJson(RelatedToName relatedToName, RelatedToValue value) {
    return MapEntry(const RelatedToNameConverter().toJson(relatedToName), value.toJson());
  }
}
