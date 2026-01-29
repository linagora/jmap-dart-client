import 'package:equatable/equatable.dart';
import 'contact_api_version.dart';
import 'context.dart';
import 'package:jmap_dart_client/http/converter/contact/context_value_converter.dart';

class LanguagePref with EquatableMixin {
  final String language; // BCP 47 tag, e.g. "en", "fr"
  final Map<Context, bool>? contexts;
  final int? pref;

  LanguagePref({
    required this.language,
    this.contexts,
    this.pref,
  });

  factory LanguagePref.fromJson(Map<String, dynamic> json) {
    return LanguagePref(
      language: json['language'] as String,
      contexts: (json['contexts'] as Map<String, dynamic>?)?.map(
        (key, value) => ContextConverter().parseEntry(key, value),
      ),
      pref: json['pref'] as int?,
    );
  }

  Map<String, dynamic> toVersionedJson(ContactApiVersion apiVersion) {
    final map = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) map[key] = value;
    }

    writeNotNull('@type', 'LanguagePref');
    writeNotNull('language', language);
    if (contexts != null) {
      writeNotNull(
        'contexts',
        contexts!.map((k, v) => ContextConverter().toJson(k, v)),
      );
    }
    writeNotNull('pref', pref);
    return map;
  }

  @override
  List<Object?> get props => [language, contexts, pref];

  @override
  String toString() {
    return 'LanguagePref('
        'language: $language, '
        'contexts: $contexts, '
        'pref: $pref'
        ')';
  }
}
