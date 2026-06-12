// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      type: json['@type'] as String? ?? 'Author',
      name: json['name'] as String?,
      uri: json['uri'] as String?,
    );

Map<String, dynamic> _$AuthorToJson(Author instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  writeNotNull('name', instance.name);
  writeNotNull('uri', instance.uri);
  return val;
}
