import 'package:equatable/equatable.dart';
import 'context.dart';
import 'package:jmap_dart_client/http/converter/contact/context_value_converter.dart';

class Directory with EquatableMixin {
  final String kind; 
  final String uri;
  final Map<Context, bool>? contexts;
  final int? pref;
  final String? label;
  final int? listAs;

  Directory({
    required this.kind,
    required this.uri,
    this.contexts,
    this.pref,
    this.label,
    this.listAs,
  });

  factory Directory.fromJson(Map<String, dynamic> json) {
    return Directory(
      kind: json['kind'] as String,
      uri: json['uri'] as String,
      contexts: (json['contexts'] as Map<String, dynamic>?)?.map(
        (k, v) => ContextConverter().parseEntry(k, v),
      ),
      pref: json['pref'] as int?,
      label: json['label'] as String?,
      listAs: json['listAs'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) map[key] = value;
    }

    writeNotNull('kind', kind);
    writeNotNull('uri', uri);
    if (contexts != null) {
      writeNotNull(
        'contexts',
        contexts!.map((k, v) => ContextConverter().toJson(k, v)),
      );
    }
    writeNotNull('pref', pref);
    writeNotNull('label', label);
    writeNotNull('listAs', listAs);
    return map;
  }

  @override
  List<Object?> get props => [kind, uri, contexts, pref, label, listAs];

  @override
  String toString() {
    return 'Directory('
        'kind: $kind, '
        'uri: $uri, '
        'contexts: $contexts, '
        'pref: $pref, '
        'label: $label, '
        'listAs: $listAs'
        ')';
  }
}
