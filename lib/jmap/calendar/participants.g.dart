// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participants.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Participants _$ParticipantsFromJson(Map<String, dynamic> json) => Participants(
      name: json['name'] as String?,
      mailto: json['mailto'] as String?,
      kind: json['kind'] as String?,
      role: json['role'] as String?,
      participationStatus: json['participationStatus'] as String?,
      expectReply: json['expectReply'] as bool?,
    );

Map<String, dynamic> _$ParticipantsToJson(Participants instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mailto': instance.mailto,
      'kind': instance.kind,
      'role': instance.role,
      'participationStatus': instance.participationStatus,
      'expectReply': instance.expectReply,
    };
