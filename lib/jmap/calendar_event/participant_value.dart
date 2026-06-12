import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/calendar_event/role_map_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/calendar_event/send_to.dart';
import 'package:jmap_dart_client/jmap/calendar_event/role.dart';
import 'package:jmap_dart_client/util/util.dart';

part 'participant_value.g.dart';

@JsonSerializable()
class ParticipantValue with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type;

  @JsonKey(includeIfNull: false)
  final String? name;

  @JsonKey(includeIfNull: false)
  final String? scheduleId;

  @JsonKey(includeIfNull: false)
  final String? kind;

  @JsonKey(includeIfNull: false)
  final String? participationStatus;

  @JsonKey(includeIfNull: false)
  final String? calendarAddress;

  @JsonKey(includeIfNull: false)
  final SendTo? sendTo;

  @RoleMapConverter()
  @JsonKey(includeIfNull: false)
  final Map<Role, bool>? roles;

  @JsonKey(includeIfNull: false, fromJson: parseBoolNullable)
  final bool? expectReply;

  @JsonKey(includeIfNull: false)
  final List<String>? scheduleStatus;

  @JsonKey(includeIfNull: false)
  final String? language;

  @JsonKey(includeIfNull: false)
  final String? email;

  ParticipantValue({
    this.type = 'Participant',
    this.name,
    this.scheduleId,
    this.kind,
    this.participationStatus,
    this.calendarAddress,
    this.sendTo,
    this.roles,
    this.expectReply,
    this.scheduleStatus,
    this.language,
    this.email,
  });

  factory ParticipantValue.fromJson(Map<String, dynamic> json) =>
      _$ParticipantValueFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantValueToJson(this);

  @override
  List<Object?> get props => [
        type,
        name,
        scheduleId,
        sendTo,
        expectReply,
        participationStatus,
        kind,
        scheduleStatus,
        language,
        calendarAddress,
        email,
        // roles intentionally NOT included, to match the manual version
      ];

  @override
  String toString() {
    return 'ParticipantValue('
        'type: $type, '
        'name: $name, '
        'scheduleId: $scheduleId, '
        'kind: $kind, '
        'participationStatus: $participationStatus, '
        'calendarAddress: $calendarAddress, '
        'sendTo: $sendTo, '
        'roles: $roles, '
        'expectReply: $expectReply, '
        'scheduleStatus: $scheduleStatus, '
        'language: $language, '
        'email: $email'
        ')';
  }
}
