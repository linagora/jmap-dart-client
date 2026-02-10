// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'files_rights.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilesRights _$FilesRightsFromJson(Map<String, dynamic> json) => FilesRights(
      mayRead: json['mayRead'] as bool,
      mayWrite: json['mayWrite'] as bool,
      mayShare: json['mayShare'] as bool,
    );

Map<String, dynamic> _$FilesRightsToJson(FilesRights instance) =>
    <String, dynamic>{
      'mayRead': instance.mayRead,
      'mayWrite': instance.mayWrite,
      'mayShare': instance.mayShare,
    };
