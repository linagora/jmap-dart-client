// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changes_file_node_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangesFileNodeMethod _$ChangesFileNodeMethodFromJson(
        Map<String, dynamic> json) =>
    ChangesFileNodeMethod(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      const StateConverter().fromJson(json['sinceState'] as String),
      maxChanges: const UnsignedIntNullableConverter()
          .fromJson((json['maxChanges'] as num?)?.toInt()),
    );

Map<String, dynamic> _$ChangesFileNodeMethodToJson(
    ChangesFileNodeMethod instance) {
  final val = <String, dynamic>{
    'accountId': const AccountIdConverter().toJson(instance.accountId),
    'sinceState': const StateConverter().toJson(instance.sinceState),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('maxChanges',
      const UnsignedIntNullableConverter().toJson(instance.maxChanges));

  return val;
}
