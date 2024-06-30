import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/is_subscribed_converter.dart';
import 'package:jmap_dart_client/http/converter/mailbox_id_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/mailbox_name_converter.dart';
import 'package:jmap_dart_client/http/converter/namespace_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/role_converter.dart';
import 'package:jmap_dart_client/http/converter/sort_order_converter.dart';
import 'package:jmap_dart_client/http/converter/total_email_converter.dart';
import 'package:jmap_dart_client/http/converter/total_threads_converter.dart';
import 'package:jmap_dart_client/http/converter/unread_emails_converter.dart';
import 'package:jmap_dart_client/http/converter/unread_threads_converter.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox_rights.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/namespace.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mailbox.g.dart';

@NamespaceNullableConverter()
@IsSubscribedConverter()
@UnreadThreadsConverter()
@UnreadEmailsConverter()
@TotalThreadsConverter()
@TotalEmailConverter()
@SortOrderConverter()
@RoleConverter()
@MailboxIdNullableConverter()
@MailboxNameConverter()
@JsonSerializable()
class Mailbox with EquatableMixin {
  @JsonKey(includeIfNull: false)
  final MailboxId? id;

  @JsonKey(includeIfNull: false)
  final MailboxName? name;

  @JsonKey(includeIfNull: false)
  final MailboxId? parentId;

  @JsonKey(includeIfNull: false)
  final Role? role;

  @JsonKey(includeIfNull: false)
  final SortOrder? sortOrder;

  @JsonKey(includeIfNull: false)
  final TotalEmails? totalEmails;

  @JsonKey(includeIfNull: false)
  final UnreadEmails? unreadEmails;

  @JsonKey(includeIfNull: false)
  final TotalThreads? totalThreads;

  @JsonKey(includeIfNull: false)
  final UnreadThreads? unreadThreads;

  @JsonKey(includeIfNull: false)
  final MailboxRights? myRights;

  @JsonKey(includeIfNull: false)
  final IsSubscribed? isSubscribed;

  @JsonKey(includeIfNull: false)
  final Namespace? namespace;

  @JsonKey(includeIfNull: false)
  final Map<String, List<String>?>? rights;

  Mailbox({
    this.id,
    this.name,
    this.parentId,
    this.role,
    this.sortOrder,
    this.totalEmails,
    this.unreadEmails,
    this.totalThreads,
    this.unreadThreads,
    this.myRights,
    this.isSubscribed,
    this.namespace,
    this.rights
  });

  factory Mailbox.fromJson(Map<String, dynamic> json) => _$MailboxFromJson(json);

  Map<String, dynamic> toJson() => _$MailboxToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    parentId,
    role,
    sortOrder,
    totalEmails,
    unreadEmails,
    totalThreads,
    unreadThreads,
    myRights,
    isSubscribed,
    namespace,
    rights
  ];
}

class MailboxId with EquatableMixin {
  final Id id;

  MailboxId(this.id);

  @override
  List<Object?> get props => [id];
}

class MailboxName with EquatableMixin {
  final String name;

  MailboxName(this.name);

  @override
  List<Object?> get props => [name];
}

class Role with EquatableMixin {
  final String value;

  // JMAP spec states that mailboxes role must be one of IMAP Mailbox Name Attributes
  // https://www.iana.org/assignments/imap-mailbox-name-attributes/imap-mailbox-name-attributes.xhtml
  // According to this link, the attribute name for Junk/Spam folder is `junk`
  // However, some servers and client use `spam` instead for historical reasons
  // To allow compatibility, convert `spam` to `junk`.
  // This should be removed some day, when every server and client has been fixed
  Role(value) : value = value == "spam" ? "junk" : value;

  @override
  List<Object?> get props => [value];
}

class SortOrder with EquatableMixin {
  late final UnsignedInt value;

  SortOrder({int sortValue = 0}) {
    value = UnsignedInt(sortValue);
  }

  @override
  List<Object?> get props => [value];
}

class TotalEmails with EquatableMixin {
  final UnsignedInt value;

  TotalEmails(this.value);

  @override
  List<Object?> get props => [value];
}

class UnreadEmails with EquatableMixin {
  final UnsignedInt value;

  UnreadEmails(this.value);

  @override
  List<Object?> get props => [value];
}

class TotalThreads with EquatableMixin {
  final UnsignedInt value;

  TotalThreads(this.value);

  @override
  List<Object?> get props => [value];
}

class UnreadThreads with EquatableMixin {
  final UnsignedInt value;

  UnreadThreads(this.value);

  @override
  List<Object?> get props => [value];
}

class IsSubscribed with EquatableMixin {
  final bool value;

  IsSubscribed(this.value);

  @override
  List<Object?> get props => [value];
}
