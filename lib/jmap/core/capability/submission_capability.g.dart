// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmissionCapability _$SubmissionCapabilityFromJson(
        Map<String, dynamic> json) =>
    SubmissionCapability(
      const UnsignedIntConverter().fromJson(json['maxDelayedSend'] as int),
      (json['submissionExtensions'] as List<dynamic>)
          .map((e) => e as String)
          .toSet(),
    );

Map<String, dynamic> _$SubmissionCapabilityToJson(
        SubmissionCapability instance) =>
    <String, dynamic>{
      'maxDelayedSend':
          const UnsignedIntConverter().toJson(instance.maxDelayedSend),
      'submissionExtensions': instance.submissionExtensions.toList(),
    };
