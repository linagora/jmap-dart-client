// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mdn.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MDN _$MDNFromJson(Map<String, dynamic> json) => MDN(
      disposition: json['disposition'] == null
          ? null
          : Disposition.fromJson(json['disposition'] as Map<String, dynamic>),
      forEmailId: const EmailIdNullableConverter()
          .fromJson(json['forEmailId'] as String?),
      subject: json['subject'] as String?,
      textBody: json['textBody'] as String?,
      includeOriginalMessage: json['includeOriginalMessage'] as bool?,
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

Map<String, dynamic> _$MDNToJson(MDN instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('forEmailId',
      const EmailIdNullableConverter().toJson(instance.forEmailId));
  writeNotNull('subject', instance.subject);
  writeNotNull('textBody', instance.textBody);
  writeNotNull('includeOriginalMessage', instance.includeOriginalMessage);
  writeNotNull('reportingUA', instance.reportingUA);
  writeNotNull('disposition', instance.disposition?.toJson());
  writeNotNull('mdnGateway', instance.mdnGateway);
  writeNotNull('originalRecipient', instance.originalRecipient);
  writeNotNull('finalRecipient', instance.finalRecipient);
  writeNotNull('originalMessageId', instance.originalMessageId);
  writeNotNull('error', instance.error);
  writeNotNull('extensionFields', instance.extensionFields);
  return val;
}
