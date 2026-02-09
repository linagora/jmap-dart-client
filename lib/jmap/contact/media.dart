import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'context.dart';
import 'package:jmap_dart_client/http/converter/contact/context_map_converter.dart';

part 'media.g.dart';

@JsonSerializable()
class Media with EquatableMixin {
  final String kind;
  final String uri;
  final String? mediaType;
  @ContextsMapConverter()
  final Map<Context, bool>? contexts;
  final int? pref;
  final String? label;

  Media({
    required this.kind,
    required this.uri,
    this.mediaType,
    this.contexts,
    this.pref,
    this.label,
  });

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  Map<String, dynamic> toJson() {
    final map = _$MediaToJson(this);
    map['@type'] = 'Media';
    return map;
  }

  @override
  List<Object?> get props => [kind, uri, mediaType, contexts, pref, label];

  @override
  String toString() {
    return 'Media('
        '@type: Media, '
        'kind: $kind, '
        'uri: $uri, '
        'mediaType: $mediaType, '
        'contexts: $contexts, '
        'pref: $pref, '
        'label: $label'
        ')';
  }
}
