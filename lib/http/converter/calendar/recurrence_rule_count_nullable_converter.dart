import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/recurrence_rule/recurrence_rule_count.dart';
import 'package:json_annotation/json_annotation.dart';

class RecurrenceRuleCountNullableConverter implements JsonConverter<RecurrenceRuleCount?, int?> {
  const RecurrenceRuleCountNullableConverter();

  @override
  RecurrenceRuleCount? fromJson(int? json) => json != null ? RecurrenceRuleCount(UnsignedInt(json)) : null;

  @override
  int? toJson(RecurrenceRuleCount? object) => object?.value.value.toInt();
}