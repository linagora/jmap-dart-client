import 'package:jmap_dart_client/jmap/mail/email/email_body_part.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_body_value.dart';

class BodyValueConverter {
  MapEntry<PartId, EmailBodyValue> convert(String key, dynamic value) {
    if (value is Map<String, dynamic>) {
      return MapEntry(PartId(key), EmailBodyValue.fromJson(value));
    } else {
      return MapEntry(PartId(key), value);
    }
  }
}