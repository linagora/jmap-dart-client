import 'package:equatable/equatable.dart';
import 'context.dart';
import 'package:jmap_dart_client/http/converter/contact/context_value_converter.dart';

class Media with EquatableMixin {
  final String kind; 
  final String? uri;    
  final String? mediaType;
  final Map<Context, bool>? contexts;
  final int? pref;
  final String? label;
  final String? blobId;

  Media({
    required this.kind,
    this.uri,
    this.mediaType,
    this.contexts,
    this.pref,
    this.label,
    this.blobId,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      kind: json['kind'] as String,
      uri: json['uri'] as String?,
      mediaType: json['mediaType'] as String?,
      contexts: (json['contexts'] as Map<String, dynamic>?)?.map(
        (k, v) => ContextConverter().parseEntry(k, v),
      ),
      pref: json['pref'] as int?,
      label: json['label'] as String?,
      blobId: json['blobId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) map[key] = value;
    }

    writeNotNull('kind', kind);
    writeNotNull('uri', uri);
    writeNotNull('mediaType', mediaType);
    if (contexts != null) {
      writeNotNull(
        'contexts',
        contexts!.map((k, v) => ContextConverter().toJson(k, v)),
      );
    }
    writeNotNull('pref', pref);
    writeNotNull('label', label);
    writeNotNull('blobId', blobId);
    return map;
  }

  @override
  List<Object?> get props => [kind, uri, mediaType, contexts, pref, label, blobId];

  @override
  String toString() {
    return 'Media('
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
