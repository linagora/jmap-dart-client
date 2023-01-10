// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailbox_filter_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailboxFilterCondition _$MailboxFilterConditionFromJson(
        Map<String, dynamic> json) =>
    MailboxFilterCondition(
      role: const RoleConverter().fromJson(json['role'] as String?),
      parentId: const MailboxIdNullableConverter()
          .fromJson(json['parentId'] as String?),
      name: const MailboxNameConverter().fromJson(json['name'] as String?),
      hasAnyRole: json['hasAnyRole'] as bool?,
      isSubscribed: json['isSubscribed'] as bool?,
    );

Map<String, dynamic> _$MailboxFilterConditionToJson(
    MailboxFilterCondition instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('role', const RoleConverter().toJson(instance.role));
  writeNotNull('name', const MailboxNameConverter().toJson(instance.name));
  writeNotNull('hasAnyRole', instance.hasAnyRole);
  writeNotNull('isSubscribed', instance.isSubscribed);
  writeNotNull(
      'parentId', const MailboxIdNullableConverter().toJson(instance.parentId));
  return val;
}
