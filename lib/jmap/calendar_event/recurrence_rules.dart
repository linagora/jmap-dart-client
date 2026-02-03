import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/calendar_event/by_day.dart';

/// JSCalendar RecurrenceRule representation
class RecurrenceRules extends Equatable {
  final String? frequency;        // e.g. "daily", "weekly", "monthly", "yearly"
  final String? type;             // @type, normally "RecurrenceRule"
  final int? interval;            // default 1
  final int? count;               // number of occurrences
  final Set<ByDay>? byDay;        // e.g. [{ "day": "mo" }, { "day": "we" }]
  final List<int>? byMonth;       // e.g. [1, 6, 10, 12]
  final List<int>? bySetPosition; // e.g. [1, -1]
  final String? until;            // LocalDateTime / UTC string

  const RecurrenceRules({
    this.frequency,
    this.type,
    this.interval,
    this.count,
    this.byDay,
    this.byMonth,
    this.bySetPosition,
    this.until,
  });

  factory RecurrenceRules.fromJson(Map<String, dynamic> json) {
    List<int>? parseIntList(dynamic raw) {
      if (raw is List) {
        return raw
            .map((e) {
              if (e is int) return e;
              if (e is String) return int.parse(e);
              throw ArgumentError('Invalid int value in list: $e');
            })
            .toList();
      }
      return null;
    }

    return RecurrenceRules(
      type: json['@type'] as String?,
      frequency: json['frequency'] as String?,
      interval: json['interval'] as int?,
      count: json['count'] as int?,
      byDay: (json['byDay'] as List<dynamic>?)
          ?.map((e) => ByDay.fromJson(e as Map<String, dynamic>))
          .toSet(),
      byMonth: parseIntList(json['byMonth']),
      bySetPosition: parseIntList(json['bySetPosition']),
      until: json['until'] as String?,
    );
  }


  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) val[key] = value;
    }

    writeNotNull('@type', type);
    writeNotNull('frequency', frequency);
    writeNotNull('interval', interval);
    writeNotNull('count', count);
    writeNotNull(
      'byDay',
      byDay?.map((ByDay e) => e.toJson()).toList(),
    );
    writeNotNull('byMonth', byMonth);
    writeNotNull('bySetPosition', bySetPosition);
    writeNotNull('until', until);
    return val;
  }

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
