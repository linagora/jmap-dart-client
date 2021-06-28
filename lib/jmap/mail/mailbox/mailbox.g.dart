// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailbox.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mailbox _$MailboxFromJson(Map<String, dynamic> json) {
  return Mailbox(
    const MailboxIdConverter().fromJson(json['id'] as String),
    const MailboxNameConverter().fromJson(json['name'] as String?),
    const MailboxIdNullableConverter().fromJson(json['parentId'] as String?),
    const RoleConverter().fromJson(json['role'] as String?),
    const SortOrderConverter().fromJson(json['sortOrder'] as int?),
    const TotalEmailConverter().fromJson(json['totalEmails'] as int?),
    const UnreadEmailsConverter().fromJson(json['unreadEmails'] as int?),
    const TotalThreadsConverter().fromJson(json['totalThreads'] as int?),
    const UnreadThreadsConverter().fromJson(json['unreadThreads'] as int?),
    json['myRights'] == null
        ? null
        : MailboxRights.fromJson(json['myRights'] as Map<String, dynamic>),
    const IsSubscribedConverter().fromJson(json['isSubscribed'] as bool?),
  );
}

Map<String, dynamic> _$MailboxToJson(Mailbox instance) => <String, dynamic>{
      'id': const MailboxIdConverter().toJson(instance.id),
      'name': const MailboxNameConverter().toJson(instance.name),
      'parentId': const MailboxIdNullableConverter().toJson(instance.parentId),
      'role': const RoleConverter().toJson(instance.role),
      'sortOrder': const SortOrderConverter().toJson(instance.sortOrder),
      'totalEmails': const TotalEmailConverter().toJson(instance.totalEmails),
      'unreadEmails':
          const UnreadEmailsConverter().toJson(instance.unreadEmails),
      'totalThreads':
          const TotalThreadsConverter().toJson(instance.totalThreads),
      'unreadThreads':
          const UnreadThreadsConverter().toJson(instance.unreadThreads),
      'myRights': instance.myRights,
      'isSubscribed':
          const IsSubscribedConverter().toJson(instance.isSubscribed),
    };
