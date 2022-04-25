import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/identities/identity.dart';
import 'package:json_annotation/json_annotation.dart';

class IdentityIdNullableConverter implements JsonConverter<IdentityId?, String?> {
  const IdentityIdNullableConverter();

  @override
  IdentityId? fromJson(String? json) => json != null ? IdentityId(Id(json)) : null;

  @override
  String? toJson(IdentityId? object) => object?.id.value;
}