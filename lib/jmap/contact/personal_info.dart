import 'package:equatable/equatable.dart';
import 'context.dart';
import 'package:jmap_dart_client/http/converter/contact/context_value_converter.dart';

class PersonalInfo with EquatableMixin {
  final String kind;

  final int? level;

  final Map<Context, bool>? contexts;

  final String? label;

  PersonalInfo({
    required this.kind,
    this.level,
    this.contexts,
    this.label,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      kind: json['kind'] as String,
      level: json['level'] as int?,
      contexts: (json['contexts'] as Map<String, dynamic>?)?.map(
        (k, v) => ContextConverter().parseEntry(k, v),
      ),
      label: json['label'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    void writeNotNull(String key, dynamic value) {
      if (value != null) map[key] = value;
    }

    writeNotNull('kind', kind);
    writeNotNull('level', level);
    if (contexts != null) {
      writeNotNull(
        'contexts',
        contexts!.map((k, v) => ContextConverter().toJson(k, v)),
      );
    }
    writeNotNull('label', label);
    return map;
  }

  @override
  List<Object?> get props => [kind, level, contexts, label];

  @override
  String toString() {
    return 'PersonalInfo('
        'kind: $kind, '
        'level: $level, '
        'contexts: $contexts, '
        'label: $label'
        ')';
  }
}
