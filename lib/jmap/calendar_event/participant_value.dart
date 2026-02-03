import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/calendar_event/send_to.dart';
import 'package:jmap_dart_client/jmap/calendar_event/role.dart';
import 'package:jmap_dart_client/http/converter/calendar_event/role_value_converter.dart';

class ParticipantValue with EquatableMixin {
  final String? type;
  final String? name;
  final String? scheduleId;
  final String? kind;
  final String? participationStatus;
  final String? calendarAddress;
  final SendTo? sendTo;
  final Map<Role, bool>? roles;
  final bool? expectReply;
  final List<String>? scheduleStatus;
  final String? language;
  final String? email;

  ParticipantValue({
    this.type,
    this.name,
    this.scheduleId,
    this.sendTo,
    this.expectReply,
    this.participationStatus,
    this.kind,
    this.roles,
    this.scheduleStatus,
    this.language,
    this.calendarAddress,
    this.email,
  });

  factory ParticipantValue.fromJson(Map<String, dynamic> json) {
    return ParticipantValue(
      type: json['@type'] as String?,
      name: json['name'] as String?,
      scheduleId: json['scheduleId'] as String?,
      sendTo: json['sendTo'] == null
          ? null
          : SendTo.fromJson(json['sendTo'] as Map<String, dynamic>),
      expectReply: json['expectReply'] as bool?,
      participationStatus: json['participationStatus'] as String?,
      kind: json['kind'] as String?,
      roles: (json['roles'] as Map<String, dynamic>?)?.map(
        (key, value) => RoleConverter().parseEntry(key, value),
      ),
      scheduleStatus: (json['scheduleStatus'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      language: json['language'] as String?,
      calendarAddress: json['calendarAddress'] as String?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('@type', type);
    writeNotNull('name', name);
    writeNotNull('scheduleId', scheduleId);
    writeNotNull('sendTo', sendTo?.toJson());
    writeNotNull('expectReply', expectReply);
    writeNotNull('participationStatus', participationStatus);
    writeNotNull('kind', kind);
    writeNotNull(
      'roles',
      roles?.map(
        (key, value) => RoleConverter().toJson(key, value),
      ),
    );
    writeNotNull('scheduleStatus', scheduleStatus);
    writeNotNull('language', language);
    writeNotNull('calendarAddress', calendarAddress);
    writeNotNull('email', email);

    return val;
  }

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
