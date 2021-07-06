import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:json_annotation/json_annotation.dart';

class RoleConverter implements JsonConverter<Role?, String?> {
  const RoleConverter();

  @override
  Role? fromJson(String? json) => json != null ? Role(json) : null;

  @override
  String? toJson(Role? object) => object?.value;
}