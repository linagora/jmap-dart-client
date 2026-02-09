import 'package:equatable/equatable.dart';

class TitleValue with EquatableMixin {
  final String? type;          // from "@type"
  final String? title;         // from "title"
  final String? organization;  // from "organization"

  // IETF fields
  final String? kind;          // "title" | "role"
  final String? name;          // e.g. "Research Scientist"
  final String? organizationId; // e.g. "o2"

  TitleValue({
    this.type = 'Title',
    this.title,
    this.organization,
    this.kind,
    this.name,
    this.organizationId,
  });

  factory TitleValue.fromJson(Map<String, dynamic> json) {
    return TitleValue(
      type: json['@type'] as String? ?? json['type'] as String?,
      title: json['title'] as String?,
      organization: json['organization'] as String?,

      //IETF
      kind: json['kind'] as String?,
      name: json['name'] as String?,
      organizationId: json['organizationId'] as String?,
    );
  }

  /// Card JSON 
  Map<String, dynamic> toLegacyJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) val[key] = value;
    }

    writeNotNull('@type', type);
    writeNotNull('title', title ?? name);
    writeNotNull('organization', organization);
    return val;
  }

  ///IETF JSON
  Map<String, dynamic> toIetfJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) val[key] = value;
    }
    writeNotNull('@type', type);
    writeNotNull('kind', kind ?? (type?.toLowerCase()));
    writeNotNull('name', name ?? title);
    writeNotNull('organizationId', organizationId);
    return val;
  }

  @override
  List<Object?> get props =>
      [type, title, organization, kind, name, organizationId];

  @override
  String toString() {
    final parts = <String>[];

    if (type != null) parts.add('type: $type');
    if (title != null) parts.add('title: $title');
    if (organization != null) parts.add('organization: $organization');
    if (kind != null) parts.add('kind: $kind');
    if (name != null) parts.add('name: $name');
    if (organizationId != null) parts.add('organizationId: $organizationId');

    return 'TitleValue(${parts.join(', ')})';
  }
}
