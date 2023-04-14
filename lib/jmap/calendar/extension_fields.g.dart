// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extension_fields.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtensionFields _$ExtensionFieldsFromJson(Map<String, dynamic> json) =>
    ExtensionFields(
      videoconference: (json['videoconference'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      customheader: (json['customheader'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
    );

Map<String, dynamic> _$ExtensionFieldsToJson(ExtensionFields instance) =>
    <String, dynamic>{
      'videoconference': instance.videoconference,
      'customheader': instance.customheader,
    };
