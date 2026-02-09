import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/contact/context_map_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'context.dart';

part 'language_preference.g.dart';

@JsonSerializable()
class LanguagePref with EquatableMixin {
  final String? type;
  final String language;
  @ContextsMapConverter()
  final Map<Context, bool>? contexts;
  final int? pref;

  LanguagePref({
    required this.language,
    this.type,
    this.contexts,
    this.pref,
  });

  factory LanguagePref.fromJson(Map<String, dynamic> json) =>
      _$LanguagePrefFromJson(json);

  Map<String, dynamic> toJson() {
    final map = _$LanguagePrefToJson(this);
    map['@type'] = 'LanguagePref';
    return map;
  }

  @override
  List<Object?> get props => [language, contexts, pref];

  @override
  String toString() {
    return 'LanguagePref('
        '@type: LanguagePref, '
        'language: $language, '
        'contexts: $contexts, '
        'pref: $pref'
        ')';
  }
}