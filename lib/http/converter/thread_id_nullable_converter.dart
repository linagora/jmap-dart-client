import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:json_annotation/json_annotation.dart';

class ThreadIdNullableConverter implements JsonConverter<ThreadId?, String?> {
  const ThreadIdNullableConverter();

  @override
  ThreadId? fromJson(String? json) => json != null ? ThreadId(Id(json)) : null;

  @override
  String? toJson(ThreadId? object) => object?.id.value;
}