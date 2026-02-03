// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anniversary_place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnniversaryPlace _$AnniversaryPlaceFromJson(Map<String, dynamic> json) =>
    AnniversaryPlace(
      type: json['type'] as String?,
      fullAddress: json['fullAddress'] as String?,
    );

Map<String, dynamic> _$AnniversaryPlaceToJson(AnniversaryPlace instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  writeNotNull('fullAddress', instance.fullAddress);
  return val;
}
