// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailbox_rights.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailboxRights _$MailboxRightsFromJson(Map<String, dynamic> json) =>
    MailboxRights(
      json['mayReadItems'] as bool,
      json['mayAddItems'] as bool,
      json['mayRemoveItems'] as bool,
      json['maySetSeen'] as bool,
      json['maySetKeywords'] as bool,
      json['mayCreateChild'] as bool,
      json['mayRename'] as bool,
      json['mayDelete'] as bool,
      json['maySubmit'] as bool,
    );

Map<String, dynamic> _$MailboxRightsToJson(MailboxRights instance) =>
    <String, dynamic>{
      'mayReadItems': instance.mayReadItems,
      'mayAddItems': instance.mayAddItems,
      'mayRemoveItems': instance.mayRemoveItems,
      'maySetSeen': instance.maySetSeen,
      'maySetKeywords': instance.maySetKeywords,
      'mayCreateChild': instance.mayCreateChild,
      'mayRename': instance.mayRename,
      'mayDelete': instance.mayDelete,
      'maySubmit': instance.maySubmit,
    };
