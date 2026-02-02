import 'package:jmap_dart_client/jmap/contact/address_values.dart';
import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/contact/contact_ids.dart';

class AddressValueConverter {
  MapEntry<String, dynamic> toJson(
    AddressId id,
    AddressValue value, {
    required ContactApiVersion apiVersion,
  }) {
    return MapEntry(id.value, value.toVersionedJson(apiVersion));
  }

  MapEntry<AddressId, AddressValue> parseEntry(String key, dynamic raw) {
    final json = raw as Map<String, dynamic>;
    return MapEntry(AddressId(key), AddressValue.fromJson(json));
  }
}
