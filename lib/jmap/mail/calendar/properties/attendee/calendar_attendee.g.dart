// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_attendee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarAttendee _$CalendarAttendeeFromJson(Map<String, dynamic> json) =>
    CalendarAttendee(
      name: const CalendarAttendeeNameNullableConverter()
          .fromJson(json['name'] as String?),
      mailto: const CalendarAttendeeMailToNullableConverter()
          .fromJson(json['mailto'] as String?),
      kind: const CalendarAttendeeKindNullableConverter()
          .fromJson(json['kind'] as String?),
      role: const CalendarAttendeeRoleNullableConverter()
          .fromJson(json['role'] as String?),
      participationStatus:
          const CalendarAttendeeParticipationStatusNullableConverter()
              .fromJson(json['participationStatus'] as String?),
      expectReply: const CalendarAttendeeExpectReplyNullableConverter()
          .fromJson(json['expectReply'] as bool?),
    );

Map<String, dynamic> _$CalendarAttendeeToJson(CalendarAttendee instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name',
      const CalendarAttendeeNameNullableConverter().toJson(instance.name));
  writeNotNull('mailto',
      const CalendarAttendeeMailToNullableConverter().toJson(instance.mailto));
  writeNotNull('kind',
      const CalendarAttendeeKindNullableConverter().toJson(instance.kind));
  writeNotNull('role',
      const CalendarAttendeeRoleNullableConverter().toJson(instance.role));
  writeNotNull(
      'participationStatus',
      const CalendarAttendeeParticipationStatusNullableConverter()
          .toJson(instance.participationStatus));
  writeNotNull(
      'expectReply',
      const CalendarAttendeeExpectReplyNullableConverter()
          .toJson(instance.expectReply));
  return val;
}
