// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anniversary_place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnniversaryPlace _$AnniversaryPlaceFromJson(Map<String, dynamic> json) =>
    AnniversaryPlace(
      fullAddress: json['fullAddress'] as String?,
    );

Map<String, dynamic> _$AnniversaryPlaceToJson(AnniversaryPlace instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fullAddress', instance.fullAddress);
  return val;
}
