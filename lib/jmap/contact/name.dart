import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/contact/name_sort_as.dart';
import 'components.dart';

class Name with EquatableMixin {
  final String? type;
  final Set<Components>? components;
  final bool isOrdered;
  final String? full;
  final NameSortAs? sortAs;

  Name({
    this.type = 'Name',
    this.components,
    this.isOrdered = true,
    this.full,
    this.sortAs,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        type: json['@type'] as String?,
        components: (json['components'] as List<dynamic>?)
            ?.map((e) => Components.fromJson(e as Map<String, dynamic>))
            .toSet(),
        isOrdered: json['isOrdered'] as bool? ?? true,
        full: json['full'] as String?,
        sortAs: json['sortAs'] != null
            ? NameSortAs.fromJson(json['sortAs'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson(ContactApiVersion apiVersion) => {
        if (apiVersion != ContactApiVersion.ietf) '@type': type ?? 'Name',
        if (components != null)
          'components':
              components!.map((c) => c.toVersionedJson(apiVersion)).toList(),
        'isOrdered': isOrdered,
        if (full != null) 'full': full,
        if (sortAs != null) 'sortAs': sortAs!.toJson(),
      };

  @override
  List<Object?> get props => [type, components, isOrdered, full, sortAs];

  @override
  String toString() {
    return 'Name('
        'components: $components, '
        'isOrdered: $isOrdered, '
        'full: $full, '
        'sortAs: $sortAs'
        ')';
  }
}

