import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/contact/contact_id.dart';
import 'package:jmap_dart_client/jmap/contact/email_value.dart';


class EmailValueConverter {
  MapEntry<String, dynamic> toJson(
    EmailId id,
    EmailValue value, {
    required ContactApiVersion apiVersion,
  }) {
    return MapEntry(id.value, value.toVersionedJson(apiVersion));
  }

  MapEntry<EmailId, EmailValue> parseEntry(String key, dynamic raw) {
    final json = raw as Map<String, dynamic>;
    return MapEntry(EmailId(key), EmailValue.fromJson(json));
  }
}
