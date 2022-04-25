import 'package:jmap_dart_client/jmap/identities/identity.dart';
import 'package:json_annotation/json_annotation.dart';

class SignatureNullableConverter implements JsonConverter<Signature?, String?> {
  const SignatureNullableConverter();

  @override
  Signature? fromJson(String? json) => json != null ? Signature(json) : null;

  @override
  String? toJson(Signature? object) => object?.value;
}