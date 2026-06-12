import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/calendar_event/by_day.dart';
import 'package:jmap_dart_client/util/util.dart';

part 'recurrence_rules.g.dart';

@JsonSerializable(explicitToJson: true)
class RecurrenceRules extends Equatable {

  final String? frequency;

  @JsonKey(includeIfNull: false, name: '@type')
  final String? type;

  @JsonKey(includeIfNull: false, fromJson: parseIntNullable)
  final int? interval;

  @JsonKey(includeIfNull: false, fromJson: parseIntNullable)
  final int? count;

  @JsonKey(includeIfNull: false)
  final Set<ByDay>? byDay;

  @JsonKey(includeIfNull: false, fromJson: parseIntListNullable)
  final List<int>? byMonth;

  @JsonKey(includeIfNull: false, fromJson: parseIntListNullable)
  final List<int>? bySetPosition;

  @JsonKey(includeIfNull: false)
  final String? until;

  const RecurrenceRules({
    this.frequency,
    this.type = 'RecurrenceRule',
    this.interval,
    this.count,
    this.byDay,
    this.byMonth,
    this.bySetPosition,
    this.until,
  });

  factory RecurrenceRules.fromJson(Map<String, dynamic> json) =>
      _$RecurrenceRulesFromJson(json);

  Map<String, dynamic> toJson() => _$RecurrenceRulesToJson(this);

  @override
  List<Object?> get props => [
        frequency,
        type,
        interval,
        count,
        byDay,
        byMonth,
        bySetPosition,
        until,
      ];

  @override
  String toString() {
    return 'RecurrenceRules('
        'frequency: $frequency, '
        'type: $type, '
        'interval: $interval, '
        'count: $count, '
        'byDay: $byDay, '
        'byMonth: $byMonth, '
        'bySetPosition: $bySetPosition, '
        'until: $until'
        ')';
  }
}
