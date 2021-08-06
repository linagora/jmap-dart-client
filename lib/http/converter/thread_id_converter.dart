import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:json_annotation/json_annotation.dart';

class ThreadIdConverter implements JsonConverter<ThreadId, String> {
  const ThreadIdConverter();

  @override
  ThreadId fromJson(String json) => ThreadId(Id(json));

  @override
  String toJson(ThreadId object) => object.id.value;
}