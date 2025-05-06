// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clear_mailbox_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClearMailboxMethod _$ClearMailboxMethodFromJson(Map<String, dynamic> json) =>
    ClearMailboxMethod(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      const MailboxIdConverter().fromJson(json['mailboxId'] as String),
    );

Map<String, dynamic> _$ClearMailboxMethodToJson(ClearMailboxMethod instance) =>
    <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(instance.accountId),
      'mailboxId': const MailboxIdConverter().toJson(instance.mailboxId),
    };
