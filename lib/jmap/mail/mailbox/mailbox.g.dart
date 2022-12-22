// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailbox.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mailbox _$MailboxFromJson(Map<String, dynamic> json) => Mailbox(
      id: const MailboxIdNullableConverter().fromJson(json['id'] as String?),
      name: const MailboxNameConverter().fromJson(json['name'] as String?),
      parentId: const MailboxIdNullableConverter()
          .fromJson(json['parentId'] as String?),
      role: const RoleConverter().fromJson(json['role'] as String?),
      sortOrder: const SortOrderConverter().fromJson(json['sortOrder'] as int?),
      totalEmails:
          const TotalEmailConverter().fromJson(json['totalEmails'] as int?),
      unreadEmails:
          const UnreadEmailsConverter().fromJson(json['unreadEmails'] as int?),
      totalThreads:
          const TotalThreadsConverter().fromJson(json['totalThreads'] as int?),
      unreadThreads: const UnreadThreadsConverter()
          .fromJson(json['unreadThreads'] as int?),
      myRights: json['myRights'] == null
          ? null
          : MailboxRights.fromJson(json['myRights'] as Map<String, dynamic>),
      isSubscribed:
          const IsSubscribedConverter().fromJson(json['isSubscribed'] as bool?),
      namespace: const NamespaceNullableConverter()
          .fromJson(json['namespace'] as String?),
      rights: (json['rights'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k, (e as List<dynamic>?)?.map((e) => e as String).toList()),
      ),
    );

Map<String, dynamic> _$MailboxToJson(Mailbox instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', const MailboxIdNullableConverter().toJson(instance.id));
  writeNotNull('name', const MailboxNameConverter().toJson(instance.name));
  writeNotNull(
      'parentId', const MailboxIdNullableConverter().toJson(instance.parentId));
  writeNotNull('role', const RoleConverter().toJson(instance.role));
  writeNotNull(
      'sortOrder', const SortOrderConverter().toJson(instance.sortOrder));
  writeNotNull(
      'totalEmails', const TotalEmailConverter().toJson(instance.totalEmails));
  writeNotNull('unreadEmails',
      const UnreadEmailsConverter().toJson(instance.unreadEmails));
  writeNotNull('totalThreads',
      const TotalThreadsConverter().toJson(instance.totalThreads));
  writeNotNull('unreadThreads',
      const UnreadThreadsConverter().toJson(instance.unreadThreads));
  writeNotNull('myRights', instance.myRights);
  writeNotNull('isSubscribed',
      const IsSubscribedConverter().toJson(instance.isSubscribed));
  writeNotNull('namespace',
      const NamespaceNullableConverter().toJson(instance.namespace));
  writeNotNull('rights', instance.rights);
  return val;
}
