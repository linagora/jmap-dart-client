import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/contact/context_map_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'context.dart';

part 'language_preference.g.dart';

@JsonSerializable()
class LanguagePref with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type;
  final String language;
  @ContextsMapConverter()
  final Map<Context, bool>? contexts;
  final int? pref;

  LanguagePref({
    this.type = 'LanguagePref',
    required this.language,
    this.contexts,
    this.pref,
  });

  factory LanguagePref.fromJson(Map<String, dynamic> json) =>
      _$LanguagePrefFromJson(json);

  Map<String, dynamic> toJson() => _$LanguagePrefToJson(this);

  @override
  List<Object?> get props => [type, language, contexts, pref];

  @override
  String toString() {
    return 'LanguagePref('
        'type: $type, '
        'language: $language, '
        'contexts: $contexts, '
        'pref: $pref'
        ')';
  }
}