import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recurrence_rules.g.dart';

@JsonSerializable()
class RecurrenceRules with EquatableMixin {
  final String? frequency;
  final List<String>? byDay;
  final List<String>? byMonth;
  final List<int>? bySetPosition;
  final String? until;

  RecurrenceRules({
    this.frequency,
    this.byDay,
    this.byMonth,
    this.bySetPosition,
    this.until});

  factory RecurrenceRules.fromJson(Map<String, dynamic> json) =>
      _$RecurrenceRulesFromJson(json);

  Map<String, dynamic> toJson() => _$RecurrenceRulesToJson(this);

  @override
  List<Object?> get props => [frequency, byDay, byMonth, bySetPosition, until];
}
