import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:json_annotation/json_annotation.dart';

class MessageIdsHeaderValueNullableConverter implements JsonConverter<MessageIdsHeaderValue?, List<dynamic>?> {
  const MessageIdsHeaderValueNullableConverter();

  @override
  MessageIdsHeaderValue? fromJson(List<dynamic>? json) {
    if (json != null) {
      return MessageIdsHeaderValue(json.map((value) => value as String).toSet());
    } else {
      return null;
    }
  }

  @override
  List<dynamic>? toJson(MessageIdsHeaderValue? object) => object?.ids.toList();
}