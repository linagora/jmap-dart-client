// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileNode _$FileNodeFromJson(Map<String, dynamic> json) => FileNode(
      id: _$JsonConverterFromJson<String, Id>(
          json['id'], const IdConverter().fromJson),
      name: json['name'] as String?,
      size: json['size'] as int?,
      parentId: _$JsonConverterFromJson<String, Id>(
          json['parentId'], const IdConverter().fromJson),
      blobId: json['blobId'] as String?,
      created: json['created'] as String?,
      modified: json['modified'] as String?,
      accessed: json['accessed'] as String?,
      executable: json['executable'] as bool?,
      myRights: json['myRights'] == null
          ? null
          : FilesRights.fromJson(json['myRights'] as Map<String, dynamic>),
      shareWith: const FilesRightsMapConverter()
          .fromJson(json['shareWith'] as Map<String, dynamic>?),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$FileNodeToJson(FileNode instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'id',
      _$JsonConverterToJson<String, Id>(
          instance.id, const IdConverter().toJson));
  writeNotNull('name', instance.name);
  writeNotNull('size', instance.size);
  writeNotNull(
      'parentId',
      _$JsonConverterToJson<String, Id>(
          instance.parentId, const IdConverter().toJson));
  writeNotNull('blobId', instance.blobId);
  writeNotNull('created', instance.created);
  writeNotNull('modified', instance.modified);
  writeNotNull('accessed', instance.accessed);
  writeNotNull('executable', instance.executable);
  writeNotNull('myRights', instance.myRights);
  writeNotNull(
      'shareWith', const FilesRightsMapConverter().toJson(instance.shareWith));
  writeNotNull('type', instance.type);
  return val;
}

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
