// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailCapability _$MailCapabilityFromJson(Map<String, dynamic> json) {
  return MailCapability(
    json['maxMailboxesPerEmail'] as int?,
    json['maxMailboxDepth'] as int?,
    json['maxSizeMailboxName'] as int?,
    json['maxSizeAttachmentsPerEmail'] as int?,
    (json['emailQuerySortOptions'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    json['mayCreateTopLevelMailbox'] as bool?,
  );
}

Map<String, dynamic> _$MailCapabilityToJson(MailCapability instance) =>
    <String, dynamic>{
      'maxMailboxesPerEmail': instance.maxMailboxesPerEmail,
      'maxMailboxDepth': instance.maxMailboxDepth,
      'maxSizeMailboxName': instance.maxSizeMailboxName,
      'maxSizeAttachmentsPerEmail': instance.maxSizeAttachmentsPerEmail,
      'emailQuerySortOptions': instance.emailQuerySortOptions,
      'mayCreateTopLevelMailbox': instance.mayCreateTopLevelMailbox,
    };
