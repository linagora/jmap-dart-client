import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/calendar/calendar_duration_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/calendar/calendar_extension_fields_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/calendar/calendar_priority_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/calendar/calendar_sequence_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/calendar/event_id_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/calendar_duration.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/calendar_event_status.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/calendar_extension_fields.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/calendar_free_busy_status.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/calendar_organizer.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/calendar_privacy.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/calendar_priority.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/calendar_sequence.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/event_id.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/event_method.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/recurrence_rule/recurrence_rule.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_event.g.dart';

@CalendarPriorityNullableConverter()
@CalendarSequenceNullableConverter()
@CalendarDurationNullableConverter()
@EventIdNullableConverter()
@CalendarAttendeeExtensionFieldsNullableConverter()
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CalendarEvent with EquatableMixin {

  @JsonKey(name: 'uid')
  final EventId? eventId;

  final String? title;
  final String? description;

  @JsonKey(name: 'start')
  final DateTime? startDate;

  @JsonKey(name: 'end')
  final DateTime? endDate;

  final CalendarDuration? duration;
  final String? timeZone;
  final String? location;
  final EventMethod? method;
  final CalendarSequence? sequence;
  final CalendarPrivacy? privacy;
  final CalendarPriority? priority;
  final CalendarFreeBusyStatus? freeBusyStatus;
  final CalendarEventStatus? status;
  final CalendarOrganizer? organizer;
  final List<CalendarAttendee>? participants;
  final CalendarExtensionFields? extensionFields;
  final List<RecurrenceRule>? recurrenceRules;
  final List<RecurrenceRule>? excludedCalendarEvents;

  CalendarEvent({
    this.eventId,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.duration,
    this.timeZone,
    this.location,
    this.method,
    this.sequence,
    this.privacy,
    this.priority,
    this.freeBusyStatus,
    this.status,
    this.organizer,
    this.participants,
    this.extensionFields,
    this.recurrenceRules,
    this.excludedCalendarEvents
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) => _$CalendarEventFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarEventToJson(this);

  @override
  List<Object?> get props => [
    eventId,
    title,
    description,
    startDate,
    endDate,
    duration,
    timeZone,
    location,
    method,
    sequence,
    privacy,
    priority,
    freeBusyStatus,
    status,
    organizer,
    participants,
    extensionFields,
    recurrenceRules,
    excludedCalendarEvents
  ];
}