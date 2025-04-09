// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_thread_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetThreadMethod _$GetThreadMethodFromJson(Map<String, dynamic> json) =>
    GetThreadMethod(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      (json['ids'] as List<dynamic>)
          .map((e) => const ThreadIdConverter().fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$GetThreadMethodToJson(GetThreadMethod instance) =>
    <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(instance.accountId),
      'ids': instance.ids.map(const ThreadIdConverter().toJson).toList(),
    };
