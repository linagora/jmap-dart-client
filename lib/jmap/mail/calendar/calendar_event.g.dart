// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEvent _$CalendarEventFromJson(Map<String, dynamic> json) =>
    CalendarEvent(
      eventId:
          const EventIdNullableConverter().fromJson(json['uid'] as String?),
      title: json['title'] as String?,
      description: json['description'] as String?,
      startDate: json['start'] == null
          ? null
          : DateTime.parse(json['start'] as String),
      endDate:
          json['end'] == null ? null : DateTime.parse(json['end'] as String),
      duration: const CalendarDurationNullableConverter()
          .fromJson(json['duration'] as String?),
      timeZone: json['timeZone'] as String?,
      location: json['location'] as String?,
      method: $enumDecodeNullable(_$EventMethodEnumMap, json['method']),
      sequence: const CalendarSequenceNullableConverter()
          .fromJson(json['sequence'] as int?),
      privacy: $enumDecodeNullable(_$CalendarPrivacyEnumMap, json['privacy']),
      priority: const CalendarPriorityNullableConverter()
          .fromJson(json['priority'] as int?),
      freeBusyStatus: $enumDecodeNullable(
          _$CalendarFreeBusyStatusEnumMap, json['freeBusyStatus']),
      status: $enumDecodeNullable(_$CalendarEventStatusEnumMap, json['status']),
      organizer: json['organizer'] == null
          ? null
          : CalendarOrganizer.fromJson(
              json['organizer'] as Map<String, dynamic>),
      participants: (json['participants'] as List<dynamic>?)
          ?.map((e) => CalendarAttendee.fromJson(e as Map<String, dynamic>))
          .toList(),
      extensionFields: const CalendarAttendeeExtensionFieldsNullableConverter()
          .fromJson(json['extensionFields']),
      recurrenceRules: (json['recurrenceRules'] as List<dynamic>?)
          ?.map((e) => RecurrenceRule.fromJson(e as Map<String, dynamic>))
          .toList(),
      excludedCalendarEvents: (json['excludedCalendarEvents'] as List<dynamic>?)
          ?.map((e) => RecurrenceRule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CalendarEventToJson(CalendarEvent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'uid', const EventIdNullableConverter().toJson(instance.eventId));
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('start', instance.startDate?.toIso8601String());
  writeNotNull('end', instance.endDate?.toIso8601String());
  writeNotNull('duration',
      const CalendarDurationNullableConverter().toJson(instance.duration));
  writeNotNull('timeZone', instance.timeZone);
  writeNotNull('location', instance.location);
  writeNotNull('method', _$EventMethodEnumMap[instance.method]);
  writeNotNull('sequence',
      const CalendarSequenceNullableConverter().toJson(instance.sequence));
  writeNotNull('privacy', _$CalendarPrivacyEnumMap[instance.privacy]);
  writeNotNull('priority',
      const CalendarPriorityNullableConverter().toJson(instance.priority));
  writeNotNull('freeBusyStatus',
      _$CalendarFreeBusyStatusEnumMap[instance.freeBusyStatus]);
  writeNotNull('status', _$CalendarEventStatusEnumMap[instance.status]);
  writeNotNull('organizer', instance.organizer?.toJson());
  writeNotNull(
      'participants', instance.participants?.map((e) => e.toJson()).toList());
  writeNotNull(
      'extensionFields',
      const CalendarAttendeeExtensionFieldsNullableConverter()
          .toJson(instance.extensionFields));
  writeNotNull('recurrenceRules',
      instance.recurrenceRules?.map((e) => e.toJson()).toList());
  writeNotNull('excludedCalendarEvents',
      instance.excludedCalendarEvents?.map((e) => e.toJson()).toList());
  return val;
}

const _$EventMethodEnumMap = {
  EventMethod.publish: 'PUBLISH',
  EventMethod.request: 'REQUEST',
  EventMethod.reply: 'REPLY',
  EventMethod.add: 'ADD',
  EventMethod.cancel: 'CANCEL',
  EventMethod.refresh: 'REFRESH',
  EventMethod.counter: 'COUNTER',
  EventMethod.declineCounter: 'DECLINECOUNTER',
};

const _$CalendarPrivacyEnumMap = {
  CalendarPrivacy.public: 'public',
  CalendarPrivacy.private: 'private',
  CalendarPrivacy.secret: 'secret',
};

const _$CalendarFreeBusyStatusEnumMap = {
  CalendarFreeBusyStatus.free: 'free',
  CalendarFreeBusyStatus.busy: 'busy',
};

const _$CalendarEventStatusEnumMap = {
  CalendarEventStatus.confirmed: 'confirmed',
  CalendarEventStatus.cancelled: 'cancelled',
  CalendarEventStatus.tentative: 'tentative',
};
