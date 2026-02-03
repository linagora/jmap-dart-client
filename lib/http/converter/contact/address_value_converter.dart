import 'package:jmap_dart_client/jmap/contact/address_values.dart';
import 'package:jmap_dart_client/jmap/contact/contact_ids.dart';

class AddressValueConverter {
  MapEntry<AddressId, AddressValue> parseEntry(String key, dynamic value) {
    if (value is Map<String, dynamic>) {
      return MapEntry(AddressId(key), AddressValue.fromJson(value));
    }
    return MapEntry(AddressId(key), value);
  }

  MapEntry<String, dynamic> toJson(AddressId addressId, AddressValue value) {
    return MapEntry(addressId.value, value.toJson());
  }
}
