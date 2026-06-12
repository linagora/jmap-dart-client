import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/contact/context_map_converter.dart';
import 'package:jmap_dart_client/util/util.dart';
import 'package:json_annotation/json_annotation.dart';
import 'context.dart';

part 'media.g.dart';

@JsonSerializable(includeIfNull: false)
class Media with EquatableMixin {
  @JsonKey(name: '@type')
  final String? type;
  final String kind;
  final String? uri;
  final String? mediaType;
  @ContextsMapConverter()
  final Map<Context, bool>? contexts;
  @JsonKey(fromJson: parseIntNullable)
  final int? pref;
  final String? label;
  final String? blobId;

  Media({
    this.type = 'Media',
    required this.kind,
    this.uri,
    this.mediaType,
    this.contexts,
    this.pref,
    this.label,
    this.blobId,
  });

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  Map<String, dynamic> toJson() => _$MediaToJson(this);

  @override
  List<Object?> get props =>
      [type, kind, uri, mediaType, contexts, pref, label, blobId];

  @override
  String toString() {
    return 'Media('
        '@type: $type, '
        'kind: $kind, '
        'uri: $uri, '
        'mediaType: $mediaType, '
        'contexts: $contexts, '
        'pref: $pref, '
        'label: $label, '
        'blobId: $blobId'
        ')';
  }
}
