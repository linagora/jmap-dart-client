import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/contact/context_value_converter.dart';
import 'package:jmap_dart_client/jmap/contact/context.dart';

class SchedulingAddress with EquatableMixin {
  final String? uri;
  final Map<Context, bool>? contexts;
  final int? pref;
  final String? label;

  SchedulingAddress({
    this.uri,
    this.contexts,
    this.pref,
    this.label,
  });

  factory SchedulingAddress.fromJson(Map<String, dynamic> json) {
    return SchedulingAddress(
      uri: json['uri'] as String?,
      contexts: (json['contexts'] as Map<String, dynamic>?)?.map(
        (k, v) => ContextConverter().parseEntry(k, v),
      ),
      pref: json['pref'] as int?,
      label: json['label'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) map[key] = value;
    }

    writeNotNull('uri', uri);
    if (contexts != null) {
      writeNotNull(
        'contexts',
        contexts!.map((k, v) => ContextConverter().toJson(k, v)),
      );
    }
    writeNotNull('pref', pref);
    writeNotNull('label', label);
    return map;
  }

  @override
  List<Object?> get props => [uri, contexts, pref, label];

  @override
  String toString() {
    return 'SchedulingAddress('
        'uri: $uri, '
        'contexts: $contexts, '
        'pref: $pref, '
        'label: $label'
        ')';
  }
}
