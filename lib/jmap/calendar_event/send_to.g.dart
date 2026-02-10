// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_to.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendTo _$SendToFromJson(Map<String, dynamic> json) => SendTo(
      imip: json['imip'] as String?,
      other: json['other'] as String?,
    );

Map<String, dynamic> _$SendToToJson(SendTo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('imip', instance.imip);
  writeNotNull('other', instance.other);
  return val;
}
