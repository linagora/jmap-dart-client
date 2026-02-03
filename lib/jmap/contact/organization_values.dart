import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/contact/organization_unit.dart';

class OrganizationValue with EquatableMixin {
  final String? type;
  final String? name;
  final String? sortAs;
  final List<OrganizationUnit>? units;

  OrganizationValue({this.type, this.name, this.units, this.sortAs});

  factory OrganizationValue.fromJson(Map<String, dynamic> json) {
    final rawUnits = json['units'];

    List<OrganizationUnit>? parsedUnits;
    if (rawUnits is List) {
      parsedUnits = rawUnits.map<OrganizationUnit>((e) {
        if (e is Map<String, dynamic>) {
          return OrganizationUnit.fromJson(e);
        } else if (e is String) {
          return OrganizationUnit(name: e);
        } else {
          throw ArgumentError('Unsupported units element type: ${e.runtimeType}');
        }
      }).toList();
    }

    return OrganizationValue(
      type: json['@type'] as String? ?? json['type'] as String?,
      name: json['name'] as String?,
      sortAs: json['sortAs'] as String?,
      units: parsedUnits,
    );
  }

  Map<String, dynamic> toIetfJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) val[key] = value;
    }

    writeNotNull('@type', type);
    writeNotNull('name', name);
    writeNotNull('sortAs', sortAs);
    if (units != null) {
      writeNotNull(
        'units',
        units!.map((u) => u.toJson()).toList(),
      );
    }

    return val;
  }

  Map<String, dynamic> toJsContactJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) val[key] = value;
    }

    writeNotNull('@type', type);
    writeNotNull('name', name);
    writeNotNull('sortAs', sortAs);
    if (units != null) {
      writeNotNull(
        'units',
        units!
            .map((u) => u.name)
            .where((n) => n != null)
            .toList(),
      );
    }

    return val;
  }

  Map<String, dynamic> toVersionedJson(ContactApiVersion apiVersion) {
    return apiVersion == ContactApiVersion.ietf
        ? toIetfJson()
        : toJsContactJson();
  }

  @override
  List<Object?> get props => [type, name, units, sortAs];

  @override
  String toString() {
    return 'OrganizationValue('
        'type: $type, '
        'name: $name, '
        'sortAs: $sortAs, '
        'units: $units'
        ')';
  }
}
