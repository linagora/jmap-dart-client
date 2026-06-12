import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/contact/contact_id.dart';
import 'package:jmap_dart_client/jmap/contact/organization_value.dart';

class OrganizationValueConverter {
  MapEntry<String, dynamic> toJson(
    OrganizationName id,
    OrganizationValue value, {
    required ContactApiVersion apiVersion,
  }) {
    return MapEntry(
      id.value,
      value.toVersionedJson(apiVersion),
    );
  }

  MapEntry<OrganizationName, OrganizationValue> parseEntry(
    String key,
    dynamic value,
    ContactApiVersion apiVersion,
  ) {
    return MapEntry(
      OrganizationName(key),
      OrganizationValue.fromJson(
        value as Map<String, dynamic>,
      ),
    );
  }
}
