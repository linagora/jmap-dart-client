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
    final jsonListIds = json[key];

    if (jsonListIds == null) return null;

    if (jsonListIds.runtimeType != List<String>) return null;

    return (jsonListIds as List<String>)
      .map((value) => const IdConverter().fromJson(value))
      .toList();
  }

  List<EventId>? parsingListEventId(Map<String, dynamic> json, String key) {
    final jsonListIds = json[key];

    if (jsonListIds == null) return null;

    if (jsonListIds.runtimeType != List<String>) return null;

    return (jsonListIds as List<String>)
      .map((value) => const EventIdNullableConverter().fromJson(value))
      .where((element) => element != null)
      .cast<EventId>()
      .toList();
  }
}