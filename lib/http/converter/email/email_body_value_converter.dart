import 'package:jmap_dart_client/http/converter/part_id_converter.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_body_part.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_body_value.dart';

class EmailBodyValueConverter {
  MapEntry<PartId, EmailBodyValue> parseEntry(String key, dynamic value) {
    if (value is Map<String, dynamic>) {
      return MapEntry(PartId(key), EmailBodyValue.fromJson(value));
    } else {
      return MapEntry(PartId(key), value);
    }
  }

  MapEntry<String, dynamic> toJson(PartId partId, EmailBodyValue value) {
    return MapEntry(PartIdConverter().toJson(partId), value.toJson());
  }
}