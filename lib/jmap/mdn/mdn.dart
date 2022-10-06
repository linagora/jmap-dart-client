import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/id_nullable_converter.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/mdn/disposition.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mdn.g.dart';

@IdNullableConverter()
@JsonSerializable()
class Mdn with EquatableMixin {

  final Id? forEmailId;
  
  final String? subject;
  
  final String? textBody;
  
  final bool includeOriginalMessage;
  
  final String? reportingUA;
  
  final Disposition disposition;
  
  final String? mdnGateway;
  
  final String? originalRecipient;
  
  final String? finalRecipient;
  
  final String? originalMessageId;
  
  final List<String>? error;
  
  final Map<String,String>? extensionFields;
  
  Mdn({
    required this.disposition,
    this.forEmailId,
    this.subject,
    this.textBody,
    this.includeOriginalMessage = false,
    this.reportingUA,
    this.mdnGateway,
    this.originalRecipient,
    this.finalRecipient,
    this.originalMessageId,
    this.error,
    this.extensionFields,
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
    extensionFields,
  ];

  factory Mdn.fromJson(Map<String, dynamic> json) => _$MdnFromJson(json);

  Map<String, dynamic> toJson() => _$MdnToJson(this);
}