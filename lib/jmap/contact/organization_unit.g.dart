// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationUnit _$OrganizationUnitFromJson(Map<String, dynamic> json) =>
    OrganizationUnit(
      type: json['@type'] as String? ?? 'OrgUnit',
      name: json['name'] as String?,
    );

Map<String, dynamic> _$OrganizationUnitToJson(OrganizationUnit instance) {
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
