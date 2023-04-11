// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changes_email_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangesEmailResponse _$ChangesEmailResponseFromJson(
        Map<String, dynamic> json) =>
    ChangesEmailResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      const StateConverter().fromJson(json['oldState'] as String),
      const StateConverter().fromJson(json['newState'] as String),
      json['hasMoreChanges'] as bool,
      (json['created'] as List<dynamic>)
          .map((e) => const IdConverter().fromJson(e as String))
          .toSet(),
      (json['updated'] as List<dynamic>)
          .map((e) => const IdConverter().fromJson(e as String))
          .toSet(),
      (json['destroyed'] as List<dynamic>)
          .map((e) => const IdConverter().fromJson(e as String))
          .toSet(),
    );

Map<String, dynamic> _$ChangesEmailResponseToJson(
        ChangesEmailResponse instance) =>
    <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(instance.accountId),
      'oldState': const StateConverter().toJson(instance.oldState),
      'newState': const StateConverter().toJson(instance.newState),
      'hasMoreChanges': instance.hasMoreChanges,
      'created': instance.created.map(const IdConverter().toJson).toList(),
      'updated': instance.updated.map(const IdConverter().toJson).toList(),
      'destroyed': instance.destroyed.map(const IdConverter().toJson).toList(),
    };
