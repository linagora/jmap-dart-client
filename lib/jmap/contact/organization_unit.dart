import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization_unit.g.dart';

@JsonSerializable()
class OrganizationUnit with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type;

  final String? name;

  OrganizationUnit({
    this.type,
    this.name,
  });

  factory OrganizationUnit.orgUnit({String? name}) =>
      OrganizationUnit(type: 'OrgUnit', name: name);

  factory OrganizationUnit.fromJson(Map<String, dynamic> json) =>
      _$OrganizationUnitFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationUnitToJson(this);

  @override
  List<Object?> get props => [type, name];

  @override
  String toString() => 'OrganizationUnit(type: $type, name: $name)';
}
