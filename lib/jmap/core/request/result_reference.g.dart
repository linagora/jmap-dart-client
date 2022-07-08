// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_reference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultReference _$ResultReferenceFromJson(Map<String, dynamic> json) =>
    ResultReference(
      const MethodCallIdConverter().fromJson(json['resultOf'] as String),
      const MethodNameConverter().fromJson(json['name'] as String),
      const ReferencePathConverter().fromJson(json['path'] as String),
    );

Map<String, dynamic> _$ResultReferenceToJson(ResultReference instance) =>
    <String, dynamic>{
      'resultOf': const MethodCallIdConverter().toJson(instance.resultOf),
      'name': const MethodNameConverter().toJson(instance.name),
      'path': const ReferencePathConverter().toJson(instance.path),
    };
