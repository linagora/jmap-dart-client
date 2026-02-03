// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_as.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SortAs _$SortAsFromJson(Map<String, dynamic> json) => SortAs(
      surname: json['surname'] as String?,
      given: json['given'] as String?,
    );

Map<String, dynamic> _$SortAsToJson(SortAs instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('surname', instance.surname);
  writeNotNull('given', instance.given);
  return val;
}
