// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailCapability _$MailCapabilityFromJson(Map<String, dynamic> json) {
  return MailCapability(
    const UnsignedIntNullableConverter()
        .fromJson(json['maxMailboxesPerEmail'] as int?),
    const UnsignedIntNullableConverter()
        .fromJson(json['maxMailboxDepth'] as int?),
    const UnsignedIntConverter().fromJson(json['maxSizeMailboxName'] as int),
    const UnsignedIntConverter()
        .fromJson(json['maxSizeAttachmentsPerEmail'] as int),
    (json['emailQuerySortOptions'] as List<dynamic>)
        .map((e) => e as String)
        .toSet(),
    json['mayCreateTopLevelMailbox'] as bool,
  );
}

Map<String, dynamic> _$MailCapabilityToJson(MailCapability instance) =>
    <String, dynamic>{
      'maxMailboxesPerEmail': const UnsignedIntNullableConverter()
          .toJson(instance.maxMailboxesPerEmail),
      'maxMailboxDepth':
          const UnsignedIntNullableConverter().toJson(instance.maxMailboxDepth),
      'maxSizeMailboxName':
          const UnsignedIntConverter().toJson(instance.maxSizeMailboxName),
      'maxSizeAttachmentsPerEmail': const UnsignedIntConverter()
          .toJson(instance.maxSizeAttachmentsPerEmail),
      'emailQuerySortOptions': instance.emailQuerySortOptions.toList(),
      'mayCreateTopLevelMailbox': instance.mayCreateTopLevelMailbox,
    };
