import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/util/util.dart';
import 'package:json_annotation/json_annotation.dart';

import 'context.dart';
import 'package:jmap_dart_client/http/converter/contact/context_map_converter.dart';

part 'directory.g.dart';

@JsonSerializable()
class Directory with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type; 
  final String kind; // "directory" or "entry"
  final String uri;

  @ContextsMapConverter()
  final Map<Context, bool>? contexts;

  @JsonKey(fromJson: parseIntNullable)
  final int? pref;
  final String? label;
  @JsonKey(fromJson: parseIntNullable)
  final int? listAs;

  Directory({
    this.type = 'Directory',
    required this.kind,
    required this.uri,
    this.contexts,
    this.pref,
    this.label,
    this.listAs,
  });

  factory Directory.fromJson(Map<String, dynamic> json) =>
      _$DirectoryFromJson(json);

  Map<String, dynamic> toJson() => _$DirectoryToJson(this);

  @override
  List<Object?> get props => [type, kind, uri, contexts, pref, label, listAs];

  @override
  String toString() {
    return 'Directory('
        'type: $type, '
        'kind: $kind, '
        'uri: $uri, '
        'contexts: $contexts, '
        'pref: $pref, '
        'label: $label, '
        'listAs: $listAs'
        ')';
  }
}
