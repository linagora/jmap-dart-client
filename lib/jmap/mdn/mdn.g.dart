// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mdn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mdn _$MdnFromJson(Map<String, dynamic> json) => Mdn(
      disposition:
          Disposition.fromJson(json['disposition'] as Map<String, dynamic>),
      forEmailId:
          const IdNullableConverter().fromJson(json['forEmailId'] as String?),
      subject: json['subject'] as String?,
      textBody: json['textBody'] as String?,
      includeOriginalMessage: json['includeOriginalMessage'] as bool? ?? false,
      reportingUA: json['reportingUA'] as String?,
      mdnGateway: json['mdnGateway'] as String?,
      originalRecipient: json['originalRecipient'] as String?,
      finalRecipient: json['finalRecipient'] as String?,
      originalMessageId: json['originalMessageId'] as String?,
      error:
          (json['error'] as List<dynamic>?)?.map((e) => e as String).toList(),
      extensionFields: (json['extensionFields'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$MdnToJson(Mdn instance) => <String, dynamic>{
      'forEmailId': const IdNullableConverter().toJson(instance.forEmailId),
      'subject': instance.subject,
      'textBody': instance.textBody,
      'includeOriginalMessage': instance.includeOriginalMessage,
      'reportingUA': instance.reportingUA,
      'disposition': instance.disposition,
      'mdnGateway': instance.mdnGateway,
      'originalRecipient': instance.originalRecipient,
      'finalRecipient': instance.finalRecipient,
      'originalMessageId': instance.originalMessageId,
      'error': instance.error,
      'extensionFields': instance.extensionFields,
    };
