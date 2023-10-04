// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quota.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quota _$QuotaFromJson(Map<String, dynamic> json) => Quota(
      const IdConverter().fromJson(json['id'] as String),
      $enumDecode(_$ResourceTypeEnumMap, json['resourceType']),
      $enumDecode(_$ScopeEnumMap, json['scope']),
      json['name'] as String,
      used: const UnsignedIntNullableConverter().fromJson(json['used'] as int?),
      hardLimit: const UnsignedIntNullableConverter()
          .fromJson(json['hardLimit'] as int?),
      limit:
          const UnsignedIntNullableConverter().fromJson(json['limit'] as int?),
      warnLimit: const UnsignedIntNullableConverter()
          .fromJson(json['warnLimit'] as int?),
      softLimit: const UnsignedIntNullableConverter()
          .fromJson(json['softLimit'] as int?),
      description: json['description'] as String?,
      types: (json['types'] as List<dynamic>?)
          ?.map((e) => const DataTypeConverter().fromJson(e as String))
          .toList(),
      dataTypes: (json['dataTypes'] as List<dynamic>?)
          ?.map((e) => const DataTypeConverter().fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$QuotaToJson(Quota instance) {
  final val = <String, dynamic>{
    'id': const IdConverter().toJson(instance.id),
    'resourceType': _$ResourceTypeEnumMap[instance.resourceType]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'used', const UnsignedIntNullableConverter().toJson(instance.used));
  writeNotNull('hardLimit',
      const UnsignedIntNullableConverter().toJson(instance.hardLimit));
  writeNotNull(
      'limit', const UnsignedIntNullableConverter().toJson(instance.limit));
  val['scope'] = _$ScopeEnumMap[instance.scope]!;
  val['name'] = instance.name;
  writeNotNull('dataTypes',
      instance.dataTypes?.map(const DataTypeConverter().toJson).toList());
  writeNotNull(
      'types', instance.types?.map(const DataTypeConverter().toJson).toList());
  writeNotNull('warnLimit',
      const UnsignedIntNullableConverter().toJson(instance.warnLimit));
  writeNotNull('softLimit',
      const UnsignedIntNullableConverter().toJson(instance.softLimit));
  writeNotNull('description', instance.description);
  return val;
}

const _$ResourceTypeEnumMap = {
  ResourceType.count: 'count',
  ResourceType.octets: 'octets',
};

const _$ScopeEnumMap = {
  Scope.account: 'account',
  Scope.domain: 'domain',
  Scope.global: 'global',
};
