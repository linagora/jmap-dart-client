import 'package:equatable/equatable.dart';

import 'parse.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_event.g.dart';

@JsonSerializable()
class CalendarEvent with EquatableMixin {
  final String? accountId;
  final Parsed? parsed;

  CalendarEvent({this.accountId, this.parsed});

  factory CalendarEvent.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarEventToJson(this);

  @override
  List<Object?> get props => [accountId, parsed];
}
