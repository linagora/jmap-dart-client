// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_filter_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailFilterCondition _$EmailFilterConditionFromJson(
        Map<String, dynamic> json) =>
    EmailFilterCondition(
      inMailbox: const MailboxIdNullableConverter()
          .fromJson(json['inMailbox'] as String?),
      inMailboxOtherThan: (json['inMailboxOtherThan'] as List<dynamic>?)
          ?.map((e) => const MailboxIdConverter().fromJson(e as String))
          .toSet(),
      before:
          const UTCDateNullableConverter().fromJson(json['before'] as String?),
      after:
          const UTCDateNullableConverter().fromJson(json['after'] as String?),
      minSize: const UnsignedIntNullableConverter()
          .fromJson(json['minSize'] as int?),
      maxSize: const UnsignedIntNullableConverter()
          .fromJson(json['maxSize'] as int?),
      allInThreadHaveKeyword: json['allInThreadHaveKeyword'] as String?,
      someInThreadHaveKeyword: json['someInThreadHaveKeyword'] as String?,
      noneInThreadHaveKeyword: json['noneInThreadHaveKeyword'] as String?,
      hasKeyword: json['hasKeyword'] as String?,
      notKeyword: json['notKeyword'] as String?,
      hasAttachment: json['hasAttachment'] as bool?,
      text: json['text'] as String?,
      from: json['from'] as String?,
      to: json['to'] as String?,
      cc: json['cc'] as String?,
      bcc: json['bcc'] as String?,
      subject: json['subject'] as String?,
      body: json['body'] as String?,
      header:
          (json['header'] as List<dynamic>?)?.map((e) => e as String).toSet(),
    );

Map<String, dynamic> _$EmailFilterConditionToJson(
    EmailFilterCondition instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('inMailbox',
      const MailboxIdNullableConverter().toJson(instance.inMailbox));
  writeNotNull(
      'inMailboxOtherThan',
      instance.inMailboxOtherThan
          ?.map(const MailboxIdConverter().toJson)
          .toList());
  writeNotNull(
      'before', const UTCDateNullableConverter().toJson(instance.before));
  writeNotNull(
      'after', const UTCDateNullableConverter().toJson(instance.after));
  writeNotNull(
      'minSize', const UnsignedIntNullableConverter().toJson(instance.minSize));
  writeNotNull(
      'maxSize', const UnsignedIntNullableConverter().toJson(instance.maxSize));
  writeNotNull('allInThreadHaveKeyword', instance.allInThreadHaveKeyword);
  writeNotNull('someInThreadHaveKeyword', instance.someInThreadHaveKeyword);
  writeNotNull('noneInThreadHaveKeyword', instance.noneInThreadHaveKeyword);
  writeNotNull('hasKeyword', instance.hasKeyword);
  writeNotNull('notKeyword', instance.notKeyword);
  writeNotNull('hasAttachment', instance.hasAttachment);
  writeNotNull('text', instance.text);
  writeNotNull('from', instance.from);
  writeNotNull('to', instance.to);
  writeNotNull('cc', instance.cc);
  writeNotNull('bcc', instance.bcc);
  writeNotNull('subject', instance.subject);
  writeNotNull('body', instance.body);
  writeNotNull('header', instance.header?.toList());
  return val;
}
