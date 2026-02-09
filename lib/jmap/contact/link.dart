import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/contact/context.dart';
import 'package:jmap_dart_client/http/converter/contact/context_map_converter.dart';

part 'link.g.dart';

@JsonSerializable()
class Link with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type;

  @JsonKey(includeIfNull: false)
  final String? kind;

  final String uri;

  @JsonKey(includeIfNull: false)
  final String? mediaType;

  @ContextsMapConverter()
  @JsonKey(includeIfNull: false)
  final Map<Context, bool>? contexts;

  @JsonKey(includeIfNull: false)
  final int? pref;

  @JsonKey(includeIfNull: false)
  final String? label;

  Link({
    this.type,
    this.kind,
    required this.uri,
    this.mediaType,
    this.contexts,
    this.pref,
    this.label,
  });

  factory Link.contact({
    required String uri,
    String? mediaType,
    Map<Context, bool>? contexts,
    int? pref,
    String? label,
  }) =>
      Link(
        type: 'Link',
        uri: uri,
        mediaType: mediaType,
        contexts: contexts,
        pref: pref,
        label: label,
      );

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  Map<String, dynamic> toJson() => _$LinkToJson(this);

  @override
  List<Object?> get props =>
      [type, kind, uri, mediaType, contexts, pref, label];

  @override
  String toString() {
    return 'Link('
        'type: $type, '
        'kind: $kind, '
        'uri: $uri, '
        'mediaType: $mediaType, '
        'contexts: $contexts, '
        'pref: $pref, '
        'label: $label'
        ')';
  }
}
