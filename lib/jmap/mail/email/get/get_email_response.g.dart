// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_email_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetEmailResponse _$GetEmailResponseFromJson(Map<String, dynamic> json) =>
    GetEmailResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      const StateConverter().fromJson(json['state'] as String),
      (json['list'] as List<dynamic>)
          .map(
              (e) => const EmailConverter().fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['notFound'] as List<dynamic>?)
          ?.map((e) => const IdConverter().fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$GetEmailResponseToJson(GetEmailResponse instance) =>
    <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(instance.accountId),
      'state': const StateConverter().toJson(instance.state),
      'list': instance.list.map(const EmailConverter().toJson).toList(),
      'notFound': instance.notFound?.map(const IdConverter().toJson).toList(),
    };
