// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_all_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadAllCapability _$DownloadAllCapabilityFromJson(
        Map<String, dynamic> json) =>
    DownloadAllCapability(
      endpoint: json['endpoint'] as String?,
    );

Map<String, dynamic> _$DownloadAllCapabilityToJson(
    DownloadAllCapability instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('endpoint', instance.endpoint);
  return val;
}
