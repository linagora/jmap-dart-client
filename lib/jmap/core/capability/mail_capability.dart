import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_properties.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mail_capability.g.dart';

@JsonSerializable()
class MailCapability extends CapabilityProperties with EquatableMixin {

  final int? maxMailboxesPerEmail;
  final int? maxMailboxDepth;
  final int? maxSizeMailboxName;
  final int? maxSizeAttachmentsPerEmail;
  final List<String>? emailQuerySortOptions;
  final bool? mayCreateTopLevelMailbox;

  MailCapability(
    this.maxMailboxesPerEmail,
    this.maxMailboxDepth,
    this.maxSizeMailboxName,
    this.maxSizeAttachmentsPerEmail,
    this.emailQuerySortOptions,
    this.mayCreateTopLevelMailbox,
  );

  factory MailCapability.fromJson(Map<String, dynamic> json) => _$MailCapabilityFromJson(json);

  Map<String, dynamic> toJson() => _$MailCapabilityToJson(this);

  static MailCapability deserialize(Map<String, dynamic> json) {
    return MailCapability.fromJson(json);
  }

  @override
  List<Object?> get props => [maxMailboxesPerEmail];
}