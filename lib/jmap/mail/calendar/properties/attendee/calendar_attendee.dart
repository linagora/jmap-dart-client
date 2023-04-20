import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/calendar/calendar_attendee_expect_reply_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/calendar/calendar_attendee_kind_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/calendar/calendar_attendee_mail_to_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/calendar/calendar_attendee_name_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/calendar/calendar_attendee_participation_status_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/calendar/calendar_attendee_role_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee_expect_reply.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee_kind.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee_mail_to.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee_name.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee_participation_status.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/attendee/calendar_attendee_role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_attendee.g.dart';

@CalendarAttendeeExpectReplyNullableConverter()
@CalendarAttendeeParticipationStatusNullableConverter()
@CalendarAttendeeRoleNullableConverter()
@CalendarAttendeeKindNullableConverter()
@CalendarAttendeeMailToNullableConverter()
@CalendarAttendeeNameNullableConverter()
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CalendarAttendee with EquatableMixin {

  final CalendarAttendeeName? name;
  final CalendarAttendeeMailTo? mailto;
  final CalendarAttendeeKind? kind;
  final CalendarAttendeeRole? role;
  final CalendarAttendeeParticipationStatus? participationStatus;
  final CalendarAttendeeExpectReply? expectReply;

  CalendarAttendee({
    this.name,
    this.mailto,
    this.kind,
    this.role,
    this.participationStatus,
    this.expectReply
  });

  factory CalendarAttendee.fromJson(Map<String, dynamic> json) => _$CalendarAttendeeFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarAttendeeToJson(this);

  @override
  List<Object?> get props => [
    name,
    mailto,
    kind,
    role,
    participationStatus,
    expectReply
  ];
}