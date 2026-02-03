import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/contact/phone_features_identifier.dart';

class PhoneFeatureValueConverter implements JsonConverter<PhoneFeature, String> {
  const PhoneFeatureValueConverter();

  @override
  PhoneFeature fromJson(String json) => PhoneFeature(json);

  @override
  String toJson(PhoneFeature object) => object.value;
}

