import 'package:equatable/equatable.dart';
import 'contact_api_version.dart';
import 'context.dart';
import 'package:jmap_dart_client/http/converter/contact/context_value_converter.dart';

class EmailValue with EquatableMixin {
  final String? type;
  final String? email;
  final int? pref;
  final String? label;
  final Map<Context, bool>? contexts;

  EmailValue({
    this.type = 'EmailAddress',
    this.email,
    this.pref,
    this.contexts,
    this.label,
  });

  factory EmailValue.fromJson(Map<String, dynamic> json) {
    final address = json['email'] as String? ?? json['address'] as String?;
    return EmailValue(
      type: json['@type'] as String? ?? json['type'] as String?,
      email: address,
      pref: _parsePref(json['pref']),
      label: json['label'] as String?,
      contexts: (json['contexts'] as Map<String, dynamic>?)?.map(
        (key, value) => ContextConverter().parseEntry(key, value),
      ),
    );
  }

  /// JSContact JSON.
  Map<String, dynamic> toJsContactJson() {
    final map = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) map[key] = value;
    }

    writeNotNull('@type', type);     
    writeNotNull('email', email);
    writeNotNull('pref', pref);
    writeNotNull('label', label);
    if (contexts != null) {
      writeNotNull(
        'contexts',
        contexts!
            .map((key, value) => ContextConverter().toJson(key, value)),
      );
    }
    return map;
  }

  /// IETF ContactCard JSON 
  Map<String, dynamic> toIetfJson() {
    final map = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) map[key] = value;
    }
    writeNotNull('@type', type);
    writeNotNull('address', email);
    if (contexts != null) {
      writeNotNull(
        'contexts',
        contexts!
            .map((key, value) => ContextConverter().toJson(key, value)),
      );
    }
    writeNotNull('pref', pref);
    writeNotNull('label', label);
    return map;
  }

  Map<String, dynamic> toVersionedJson(ContactApiVersion apiVersion) {
    if (apiVersion == ContactApiVersion.ietf) {
      return toIetfJson();
    }
    return toJsContactJson();
  }

  @override
  List<Object?> get props => [type, email, pref, label, contexts];

  @override
  String toString() {
    return 'EmailValue('
        'type: $type, '
        'email: $email, '
        'pref: $pref, '
        'label: $label, '
        'contexts: $contexts'
        ')';
  }
}

int? _parsePref(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  return null;
}