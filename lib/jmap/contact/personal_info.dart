import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/contact/context_map_converter.dart';
import 'package:jmap_dart_client/util/util.dart';
import 'package:json_annotation/json_annotation.dart';

import 'context.dart';

part 'personal_info.g.dart';

@JsonSerializable()
class PersonalInfo with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type; 

  final String kind;

  final String value;

  @JsonKey(includeIfNull: false)
  final String? level;

  @ContextsMapConverter()
  @JsonKey(includeIfNull: false)
  final Map<Context, bool>? contexts;

  @JsonKey(includeIfNull: false, fromJson: parseIntNullable)
  final int? listAs;

  @JsonKey(includeIfNull: false)
  final String? label;

  PersonalInfo({
    this.type = 'PersonalInfo',
    required this.kind,
    required this.value,
    this.level,
    this.contexts,
    this.listAs,
    this.label,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) =>
      _$PersonalInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalInfoToJson(this);

  @override
  List<Object?> get props =>
      [type, kind, value, level, contexts, listAs, label];

  @override
  String toString() {
    return 'PersonalInfo('
        'type: $type, '
        'kind: $kind, '
        'value: $value, '
        'level: $level, '
        'contexts: $contexts, '
        'listAs: $listAs, '
        'label: $label'
        ')';
  }
}
