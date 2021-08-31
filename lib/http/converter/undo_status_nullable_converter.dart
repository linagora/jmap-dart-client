import 'package:jmap_dart_client/jmap/mail/email/submission/email_submission.dart';
import 'package:json_annotation/json_annotation.dart';

class UndoStatusNullableConverter implements JsonConverter<UndoStatus?, String?> {
  const UndoStatusNullableConverter();

  @override
  UndoStatus? fromJson(String? json) => json != null ? UndoStatus(json) : null;

  @override
  String? toJson(UndoStatus? object) => object?.value;
}