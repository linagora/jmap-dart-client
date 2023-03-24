// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailCapability _$MailCapabilityFromJson(Map<String, dynamic> json) =>
    MailCapability(
      maxMailboxesPerEmail: const UnsignedIntNullableConverter()
          .fromJson(json['maxMailboxesPerEmail'] as int?),
      maxMailboxDepth: const UnsignedIntNullableConverter()
          .fromJson(json['maxMailboxDepth'] as int?),
      maxSizeMailboxName: const UnsignedIntNullableConverter()
          .fromJson(json['maxSizeMailboxName'] as int?),
      maxKeywordsPerEmail: const UnsignedIntNullableConverter()
          .fromJson(json['maxKeywordsPerEmail'] as int?),
      maxSizeAttachmentsPerEmail: const UnsignedIntNullableConverter()
          .fromJson(json['maxSizeAttachmentsPerEmail'] as int?),
      emailQuerySortOptions: (json['emailQuerySortOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toSet(),
      emailsListSortOptions: (json['emailsListSortOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toSet(),
      mayCreateTopLevelMailbox: json['mayCreateTopLevelMailbox'] as bool?,
    );

Map<String, dynamic> _$MailCapabilityToJson(MailCapability instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'maxMailboxesPerEmail',
      const UnsignedIntNullableConverter()
          .toJson(instance.maxMailboxesPerEmail));
  writeNotNull('maxMailboxDepth',
      const UnsignedIntNullableConverter().toJson(instance.maxMailboxDepth));
  writeNotNull('maxSizeMailboxName',
      const UnsignedIntNullableConverter().toJson(instance.maxSizeMailboxName));
  writeNotNull(
      'maxKeywordsPerEmail',
      const UnsignedIntNullableConverter()
          .toJson(instance.maxKeywordsPerEmail));
  writeNotNull(
      'maxSizeAttachmentsPerEmail',
      const UnsignedIntNullableConverter()
          .toJson(instance.maxSizeAttachmentsPerEmail));
  writeNotNull(
      'emailQuerySortOptions', instance.emailQuerySortOptions?.toList());
  writeNotNull(
      'emailsListSortOptions', instance.emailsListSortOptions?.toList());
  writeNotNull('mayCreateTopLevelMailbox', instance.mayCreateTopLevelMailbox);
  return val;
}
