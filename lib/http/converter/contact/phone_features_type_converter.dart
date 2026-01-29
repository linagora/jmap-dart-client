import 'package:jmap_dart_client/jmap/contact/phone_features_identifier.dart';

class PhoneFeaturesConverter {
  MapEntry<PhoneFeature, bool> parseEntry(String key, bool value) => MapEntry(PhoneFeature(key), value);

  MapEntry<String, bool> toJson(PhoneFeature contextValue, bool value) => MapEntry(contextValue.value, value);
}

