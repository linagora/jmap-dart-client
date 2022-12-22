import 'package:jmap_dart_client/jmap/mail/mailbox/namespace.dart';
import 'package:json_annotation/json_annotation.dart';

class NamespaceNullableConverter implements JsonConverter<Namespace?, String?> {
  const NamespaceNullableConverter();

  @override
  Namespace? fromJson(String? json) => json != null ? Namespace(json) : null;

  @override
  String? toJson(Namespace? object) => object?.value;
}