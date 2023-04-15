// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_capability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestCapability _$TestCapabilityFromJson(Map<String, dynamic> json) =>
    TestCapability(
      json['testParam1'] as int,
      json['testParam2'] as String,
      (json['testParam3'] as List<dynamic>).map((e) => e as String).toSet(),
    );

Map<String, dynamic> _$TestCapabilityToJson(TestCapability instance) =>
    <String, dynamic>{
      'testParam1': instance.testParam1,
      'testParam2': instance.testParam2,
      'testParam3': instance.testParam3.toList(),
    };
