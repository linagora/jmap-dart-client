import 'package:jmap_dart_client/http/converter/contact/phone_id_converter.dart';
import 'package:jmap_dart_client/jmap/contact/contact_ids.dart';
import 'package:jmap_dart_client/jmap/contact/phone_values.dart';


class PhoneValueConverter {
  MapEntry<PhoneId, PhoneValue> parseEntry(String key, dynamic value) {
    if (value is Map<String, dynamic>) {
      return MapEntry(PhoneId(key), PhoneValue.fromJson(value));
    } else {
      return MapEntry(PhoneId(key), value);
    }
  }

  MapEntry<String, dynamic> toJson(PhoneId phoneId, PhoneValue value) {
    return MapEntry(const PhoneIdConverter().toJson(phoneId), value.toJson());
  }
}
