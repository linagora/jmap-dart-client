import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/email_id_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:jmap_dart_client/jmap/mdn/disposition.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mdn.g.dart';

@EmailIdNullableConverter()
@JsonSerializable(explicitToJson: true)
class MDN with EquatableMixin {

  @JsonKey(includeIfNull: false)
  final EmailId? forEmailId;

  @JsonKey(includeIfNull: false)
  final String? subject;

  @JsonKey(includeIfNull: false)
  final String? textBody;

  @JsonKey(includeIfNull: false)
  final bool? includeOriginalMessage;

  @JsonKey(includeIfNull: false)
  final String? reportingUA;

  @JsonKey(includeIfNull: false)
  final Disposition? disposition;

  @JsonKey(includeIfNull: false)
  final String? mdnGateway;

  @JsonKey(includeIfNull: false)
  final String? originalRecipient;

  @JsonKey(includeIfNull: false)
  final String? finalRecipient;

  @JsonKey(includeIfNull: false)
  final String? originalMessageId;

  @JsonKey(includeIfNull: false)
  final List<String>? error;

  @JsonKey(includeIfNull: false)
  final Map<String,String>? extensionFields;

  MDN({
    this.disposition,
    this.forEmailId,
    this.subject,
    this.textBody,
    this.includeOriginalMessage,
    this.reportingUA,
    this.mdnGateway,
    this.originalRecipient,
    this.finalRecipient,
    this.originalMessageId,
    this.error,
    this.extensionFields
  });


  @override
  List<Object?> get props => [
    forEmailId,
    subject,
    textBody,
    includeOriginalMessage,
    reportingUA,
    disposition,
    mdnGateway,
    originalRecipient,
    finalRecipient,
    originalMessageId,
    error,
    extensionFields
  ];

  factory MDN.fromJson(Map<String, dynamic> json) => _$MDNFromJson(json);

  Map<String, dynamic> toJson() => _$MDNToJson(this);
}