import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/contact/context_value_converter.dart';
import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/contact/context.dart';

class OnlineServiceValue with EquatableMixin {
  final String? service;
  final String? uri;
  final String? user;
  final String? label;
  final Map<Context, bool>? contexts;

  OnlineServiceValue({
    this.service,
    this.uri,
    this.user,
    this.label,
    this.contexts,
  });

  factory OnlineServiceValue.fromJson(Map<String, dynamic> json) {
    return OnlineServiceValue(
      service: json['service'] as String?,
      uri: json['uri'] as String?,
      user: json['user'] as String?,
      label: json['label'] as String?,
      contexts: (json['contexts'] as Map<String, dynamic>?)?.map(
        (key, value) => ContextConverter().parseEntry(key, value),
      ),
    );
  }

  Map<String, dynamic> toVersionedJson(ContactApiVersion apiVersion) {
    final map = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) map[key] = value;
    }

    writeNotNull('service', service);
    writeNotNull('uri', uri);
    writeNotNull('user', user);
    writeNotNull('label', label);
    if (contexts != null) {
      writeNotNull(
        'contexts',
        contexts!.map((k, v) => ContextConverter().toJson(k, v)),
      );
    }
    return map;
  }

  @override
  List<Object?> get props => [service, uri, user, label, contexts];

  @override
  String toString() {
    return 'OnlineServiceValue('
        'service: $service, '
        'uri: $uri, '
        'user: $user, '
        'label: $label, '
        'contexts: $contexts'
        ')';
  }
}
