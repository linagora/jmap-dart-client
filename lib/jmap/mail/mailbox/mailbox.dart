import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/mailbox_id_converter.dart';
import 'package:jmap_dart_client/http/converter/mailbox_id_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/mailbox_name_converter.dart';
import 'package:jmap_dart_client/http/converter/role_converter.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/properties/properties.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mailbox.g.dart';

@RoleConverter()
@MailboxIdNullableConverter()
@MailboxNameConverter()
@MailboxIdConverter()
@JsonSerializable()
class Mailbox with EquatableMixin {
  static Properties allProperties = Properties({
    'id', 'name', 'parentId', 'role', 'sortOrder', 'totalEmails', 'unreadEmails',
    'totalThreads', 'unreadThreads', 'myRights', 'isSubscribed'
  });

  final MailboxId id;
  final MailboxName? name;
  final MailboxId? parentId;
  final Role? role;
  final SortOrder? sortOrder;
  final TotalEmails? totalEmails;
  final UnreadEmails? unreadEmails;
  final TotalThreads? totalThreads;
  final UnreadThreads? unreadThreads;
  final MailboxRights? myRights;
  final IsSubscribed? isSubscribed;

  Mailbox(
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
    this.isSubscribed
  );

  factory Mailbox.fromJson(Map<String, dynamic> json) => _$MailboxFromJson(json);

  Map<String, dynamic> toJson() => _$MailboxToJson(this);

  @override
  List<Object?> get props => [id, name, parentId, role];
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

  Role(this.value);

  @override
  List<Object?> get props => [value];
}

class SortOrder with EquatableMixin {
  late final UnsignedInt value;

  SortOrder({int sortValue = 0}) {
    this.value = UnsignedInt(sortValue);
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

class MailboxRights with EquatableMixin {
  final MayReadItems mayReadItems;
  final MayAddItems mayAddItems;
  final MayRemoveItems mayRemoveItems;
  final MaySetSeen maySetSeen;
  final MaySetKeywords maySetKeywords;
  final MayCreateChild mayCreateChild;
  final MayRename mayRename;
  final MayDelete mayDelete;
  final MaySubmit maySubmit;

  MailboxRights(
    this.mayReadItems,
    this.mayAddItems,
    this.mayRemoveItems,
    this.maySetSeen,
    this.maySetKeywords,
    this.mayCreateChild,
    this.mayRename,
    this.mayDelete,
    this.maySubmit);

  @override
  List<Object?> get props => [mayReadItems, mayAddItems, mayRemoveItems, maySetSeen,
    maySetKeywords, mayCreateChild, mayRename, mayDelete, maySubmit];
}

class MayReadItems with EquatableMixin {
  final bool value;

  MayReadItems(this.value);

  @override
  List<Object?> get props => [value];
}

class MayAddItems with EquatableMixin{
  final bool value;

  MayAddItems(this.value);

  @override
  List<Object?> get props => [value];
}

class MayRemoveItems with EquatableMixin {
  final bool value;

  MayRemoveItems(this.value);

  @override
  List<Object?> get props => [value];
}

class MaySetSeen with EquatableMixin {
  final bool value;

  MaySetSeen(this.value);

  @override
  List<Object?> get props => [value];
}

class MaySetKeywords with EquatableMixin {
  final bool value;

  MaySetKeywords(this.value);

  @override
  List<Object?> get props => [value];
}

class MayCreateChild with EquatableMixin {
  final bool value;

  MayCreateChild(this.value);

  @override
  List<Object?> get props => [value];
}

class MayRename with EquatableMixin {
  final bool value;

  MayRename(this.value);

  @override
  List<Object?> get props => [value];
}

class MayDelete with EquatableMixin {
  final bool value;

  MayDelete(this.value);

  @override
  List<Object?> get props => [value];
}

class MaySubmit with EquatableMixin {
  final bool value;

  MaySubmit(this.value);

  @override
  List<Object?> get props => [value];
}

class IsSubscribed with EquatableMixin {
  final bool value;

  IsSubscribed(this.value);

  @override
  List<Object?> get props => [value];
}

