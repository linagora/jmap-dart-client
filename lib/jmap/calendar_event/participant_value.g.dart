// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantValue _$ParticipantValueFromJson(Map<String, dynamic> json) =>
    ParticipantValue(
      type: json['@type'] as String? ?? 'Participant',
      name: json['name'] as String?,
      scheduleId: json['scheduleId'] as String?,
      kind: json['kind'] as String?,
      participationStatus: json['participationStatus'] as String?,
      calendarAddress: json['calendarAddress'] as String?,
      sendTo: json['sendTo'] == null
          ? null
          : SendTo.fromJson(json['sendTo'] as Map<String, dynamic>),
      roles: const RoleMapConverter()
          .fromJson(json['roles'] as Map<String, dynamic>?),
      expectReply: json['expectReply'] as bool?,
      scheduleStatus: (json['scheduleStatus'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      language: json['language'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$ParticipantValueToJson(ParticipantValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  writeNotNull('name', instance.name);
  writeNotNull('scheduleId', instance.scheduleId);
  writeNotNull('kind', instance.kind);
  writeNotNull('participationStatus', instance.participationStatus);
  writeNotNull('calendarAddress', instance.calendarAddress);
  writeNotNull('sendTo', instance.sendTo);
  writeNotNull('roles', const RoleMapConverter().toJson(instance.roles));
  writeNotNull('expectReply', instance.expectReply);
  writeNotNull('scheduleStatus', instance.scheduleStatus);
  writeNotNull('language', instance.language);
  writeNotNull('email', instance.email);
  return val;
}
