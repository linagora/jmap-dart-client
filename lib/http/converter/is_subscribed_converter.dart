import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:json_annotation/json_annotation.dart';

class IsSubscribedConverter implements JsonConverter<IsSubscribed?, bool?> {
  const IsSubscribedConverter();

  @override
  IsSubscribed? fromJson(bool? json) {
    return json != null ? IsSubscribed(json) : null;
  }

  @override
  bool? toJson(IsSubscribed? object) {
    return object?.value;
  }
}