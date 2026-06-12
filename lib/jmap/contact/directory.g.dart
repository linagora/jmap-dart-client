// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Directory _$DirectoryFromJson(Map<String, dynamic> json) => Directory(
      type: json['@type'] as String? ?? 'Directory',
      kind: json['kind'] as String,
      uri: json['uri'] as String,
      contexts: const ContextsMapConverter()
          .fromJson(json['contexts'] as Map<String, dynamic>?),
      pref: parseIntNullable(json['pref']),
      label: json['label'] as String?,
      listAs: parseIntNullable(json['listAs']),
    );

Map<String, dynamic> _$DirectoryToJson(Directory instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  val['kind'] = instance.kind;
  val['uri'] = instance.uri;
  val['contexts'] = const ContextsMapConverter().toJson(instance.contexts);
  val['pref'] = instance.pref;
  val['label'] = instance.label;
  val['listAs'] = instance.listAs;
  return val;
}
