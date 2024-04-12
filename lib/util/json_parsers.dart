import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/calendar/event_id_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/event_id.dart';

class JsonParsers {
  const JsonParsers._();
  factory JsonParsers() => _instance;
  static const JsonParsers _instance = JsonParsers._();

  AccountId parsingAccountId(Map<String, dynamic> json) {
    return const AccountIdConverter().fromJson(json['accountId'] as String);
  }
  
  List<Id>? parsingListId(Map<String, dynamic> json, String key) {
    return (json[key] as List<dynamic>?)
      ?.map((value) => const IdConverter().fromJson(value as String))
      .toList();
  }

  List<EventId>? parsingListEventId(Map<String, dynamic> json, String key) {
    return (json[key] as List<dynamic>?)
      ?.map((value) => const EventIdNullableConverter().fromJson(value as String))
      .where((element) => element != null)
      .cast<EventId>()
      .toList();
  }
}