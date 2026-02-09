import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/contact/context_map_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'context.dart';

part 'personal_info.g.dart';

@JsonSerializable()
class PersonalInfo with EquatableMixin {
  final String kind;
  final int? level;

  @ContextsMapConverter()
  final Map<Context, bool>? contexts;

  final String? label;

  PersonalInfo({
    required this.kind,
    this.level,
    this.contexts,
    this.label,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) =>
      _$PersonalInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalInfoToJson(this);

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
