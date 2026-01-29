// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_file_node_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFileNodeResponse _$GetFileNodeResponseFromJson(Map<String, dynamic> json) =>
    GetFileNodeResponse(
      const AccountIdConverter().fromJson(json['accountId'].toString()),
      const StateConverter().fromJson(json['state'].toString()),
      (json['list'] as List<dynamic>?)
          ?.map((e) => FileNode.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['notFound'] as List<dynamic>?)
          ?.map((e) => const IdConverter().fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$GetFileNodeResponseToJson(
        GetFileNodeResponse instance) =>
    <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(instance.accountId),
      'state': const StateConverter().toJson(instance.state),
      'list': instance.list.map((e) => e.toJson()).toList(),
      'notFound':
          instance.notFound?.map(const IdConverter().toJson).toList(),
    };
