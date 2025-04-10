// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_thread_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetThreadResponse _$GetThreadResponseFromJson(Map<String, dynamic> json) =>
    GetThreadResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      const StateConverter().fromJson(json['state'] as String),
      (json['list'] as List<dynamic>)
          .map((e) => Thread.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['notFound'] as List<dynamic>?)
          ?.map((e) => const IdConverter().fromJson(e as String))
          .toList(),
    );
