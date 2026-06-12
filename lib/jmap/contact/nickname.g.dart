// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nickname.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nickname _$NicknameFromJson(Map<String, dynamic> json) => Nickname(
      type: json['@type'] as String? ?? 'NickName',
      name: json['name'] as String?,
    );

Map<String, dynamic> _$NicknameToJson(Nickname instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  val['name'] = instance.name;
  return val;
}
