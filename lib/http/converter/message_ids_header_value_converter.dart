import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:json_annotation/json_annotation.dart';

class MessageIdsHeaderValueConverter implements JsonConverter<MessageIdsHeaderValue, List<dynamic>> {
  const MessageIdsHeaderValueConverter();

  @override
  MessageIdsHeaderValue fromJson(List<dynamic> json) => MessageIdsHeaderValue(json.map((value) =>
      IdConverter().fromJson(value)).toSet());

  @override
  List<dynamic> toJson(MessageIdsHeaderValue object) => object.ids.map((id) =>
      IdConverter().toJson(id)).toList();
}