import 'package:jmap_dart_client/http/converter/mailbox_id_converter.dart';
import 'package:jmap_dart_client/http/converter/mailbox_id_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/unsigned_int_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/utc_date_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/core/filter/filter_condition.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/core/utc_date.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email_filter_condition.g.dart';

@UTCDateNullableConverter()
@UnsignedIntNullableConverter()
@MailboxIdNullableConverter()
@MailboxIdConverter()
@JsonSerializable()
class EmailFilterCondition extends FilterCondition {

  @JsonKey(includeIfNull: false)
  final MailboxId? inMailbox;
  @JsonKey(includeIfNull: false)
  final Set<MailboxId>? inMailboxOtherThan;
  @JsonKey(includeIfNull: false)
  final UTCDate? before;
  @JsonKey(includeIfNull: false)
  final UTCDate? after;
  @JsonKey(includeIfNull: false)
  final UnsignedInt? minSize;
  @JsonKey(includeIfNull: false)
  final UnsignedInt? maxSize;
  @JsonKey(includeIfNull: false)
  final String? allInThreadHaveKeyword;
  @JsonKey(includeIfNull: false)
  final String? someInThreadHaveKeyword;
  @JsonKey(includeIfNull: false)
  final String? noneInThreadHaveKeyword;
  @JsonKey(includeIfNull: false)
  final String? hasKeyword;
  @JsonKey(includeIfNull: false)
  final String? notKeyword;
  @JsonKey(includeIfNull: false)
  final bool? hasAttachment;
  @JsonKey(includeIfNull: false)
  final String? text;
  @JsonKey(includeIfNull: false)
  final String? from;
  @JsonKey(includeIfNull: false)
  final String? to;
  @JsonKey(includeIfNull: false)
  final String? cc;
  @JsonKey(includeIfNull: false)
  final String? bcc;
  @JsonKey(includeIfNull: false)
  final String? subject;
  @JsonKey(includeIfNull: false)
  final String? body;
  @JsonKey(includeIfNull: false)
  final Set<String>? header;

  EmailFilterCondition({
    this.inMailbox,
    this.inMailboxOtherThan,
    this.before,
    this.after,
    this.minSize,
    this.maxSize,
    this.allInThreadHaveKeyword,
    this.someInThreadHaveKeyword,
    this.noneInThreadHaveKeyword,
    this.hasKeyword,
    this.notKeyword,
    this.hasAttachment,
    this.text,
    this.from,
    this.to,
    this.cc,
    this.bcc,
    this.subject,
    this.body,
    this.header,
  });

  @override
  List<Object?> get props => [
    inMailbox,
    inMailboxOtherThan,
    before,
    after,
    minSize,
    maxSize,
    allInThreadHaveKeyword,
    someInThreadHaveKeyword,
    noneInThreadHaveKeyword,
    hasKeyword,
    notKeyword,
    hasAttachment,
    text,
    from,
    to,
    cc,
    bcc,
    subject,
    body,
    header
  ];

  factory EmailFilterCondition.fromJson(Map<String, dynamic> json) =>
      _$EmailFilterConditionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EmailFilterConditionToJson(this);
}