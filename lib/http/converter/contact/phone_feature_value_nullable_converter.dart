import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/contact/phone_features_identifier.dart';

class PhoneFeatureValueNullableConverter implements JsonConverter<PhoneFeature?, String?> {
  const PhoneFeatureValueNullableConverter();

  @override
  PhoneFeature? fromJson(String? json) => json != null ? PhoneFeature(json) : null;

  @override
  String? toJson(PhoneFeature? object) => object?.value;
}