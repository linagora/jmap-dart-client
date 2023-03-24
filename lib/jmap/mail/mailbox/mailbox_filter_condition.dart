import 'package:jmap_dart_client/http/converter/mailbox_id_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/mailbox_name_converter.dart';
import 'package:jmap_dart_client/http/converter/role_converter.dart';
import 'package:jmap_dart_client/jmap/core/filter/filter_condition.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mailbox_filter_condition.g.dart';

@RoleConverter()
@MailboxNameConverter()
@JsonSerializable()
@MailboxIdNullableConverter()
class MailboxFilterCondition extends FilterCondition {

  @JsonKey(includeIfNull: false)
  final Role? role;
  @JsonKey(includeIfNull: false)
  final MailboxName? name;
  @JsonKey(includeIfNull: false)
  final bool? hasAnyRole;
  @JsonKey(includeIfNull: false)
  final bool? isSubscribed;
  @JsonKey(includeIfNull: false)
  final MailboxId? parentId;

  MailboxFilterCondition({
    this.role,
    this.parentId,
    this.name,
    this.hasAnyRole,
    this.isSubscribed,
  });

  @override
  List<Object?> get props => [
    role,
    parentId,
    name,
    hasAnyRole,
    parentId
  ];

  factory MailboxFilterCondition.fromJson(Map<String, dynamic> json) =>
      _$MailboxFilterConditionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MailboxFilterConditionToJson(this);
}