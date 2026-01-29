// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changes_file_node_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangesFileNodeResponse _$ChangesFileNodeResponseFromJson(
        Map<String, dynamic> json) =>
    ChangesFileNodeResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      const StateConverter().fromJson(json['oldState'] as String),
      const StateConverter().fromJson(json['newState'] as String),
      json['hasMoreChanges'] as bool,
      (json['created'] as List<dynamic>)
          .map((e) => const IdConverter().fromJson(e as String))
          .toSet(),
      (json['updated'] as List<dynamic>)
          .map((e) => const IdConverter().fromJson(e as String))
          .toSet(),
      (json['destroyed'] as List<dynamic>)
          .map((e) => const IdConverter().fromJson(e as String))
          .toSet(),
      updatedProperties:
          const PropertiesConverter().fromJson(json['updatedProperties']),
    );

Map<String, dynamic> _$ChangesFileNodeResponseToJson(
    ChangesFileNodeResponse instance) {
  final val = <String, dynamic>{
    'accountId': const AccountIdConverter().toJson(instance.accountId),
    'oldState': const StateConverter().toJson(instance.oldState),
    'newState': const StateConverter().toJson(instance.newState),
    'hasMoreChanges': instance.hasMoreChanges,
    'created':
        instance.created.map(const IdConverter().toJson).toList(),
    'updated':
        instance.updated.map(const IdConverter().toJson).toList(),
    'destroyed':
        instance.destroyed.map(const IdConverter().toJson).toList(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'updatedProperties',
      const PropertiesConverter().toJson(instance.updatedProperties));

  return val;
}
