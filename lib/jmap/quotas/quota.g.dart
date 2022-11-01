// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quota.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quota _$QuotaFromJson(Map<String, dynamic> json) => Quota(
      const IdConverter().fromJson(json['id'] as String),
      $enumDecode(_$ResourceTypeEnumMap, json['resourceType']),
      const UnsignedIntConverter().fromJson(json['used'] as int),
      const UnsignedIntConverter().fromJson(json['limit'] as int),
      $enumDecode(_$ScopeEnumMap, json['scope']),
      json['name'] as String,
      (json['datatypes'] as List<dynamic>)
          .map((e) => const DataTypeConverter().fromJson(e as String))
          .toList(),
      warnLimit: const UnsignedIntNullableConverter()
          .fromJson(json['warnLimit'] as int?),
      softLimit: const UnsignedIntNullableConverter()
          .fromJson(json['softLimit'] as int?),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$QuotaToJson(Quota instance) {
  final val = <String, dynamic>{
    'id': const IdConverter().toJson(instance.id),
    'resourceType': _$ResourceTypeEnumMap[instance.resourceType],
    'used': const UnsignedIntConverter().toJson(instance.used),
    'limit': const UnsignedIntConverter().toJson(instance.limit),
    'scope': _$ScopeEnumMap[instance.scope],
    'name': instance.name,
    'datatypes':
        instance.datatypes.map(const DataTypeConverter().toJson).toList(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

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
