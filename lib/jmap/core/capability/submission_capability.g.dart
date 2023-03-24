// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmissionCapability _$SubmissionCapabilityFromJson(
        Map<String, dynamic> json) =>
    SubmissionCapability(
      maxDelayedSend: const UnsignedIntNullableConverter()
          .fromJson(json['maxDelayedSend'] as int?),
      submissionExtensions:
          (json['submissionExtensions'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
    );

Map<String, dynamic> _$SubmissionCapabilityToJson(
    SubmissionCapability instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('maxDelayedSend',
      const UnsignedIntNullableConverter().toJson(instance.maxDelayedSend));
  writeNotNull('submissionExtensions', instance.submissionExtensions);
  return val;
}
