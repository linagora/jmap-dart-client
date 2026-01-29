import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'contact_api_version.dart';

class Components with EquatableMixin {
  final String? kind;
  final String? value;

  @JsonKey(name: '@type')
  final String? jsType;

  Components({
    this.kind,
    this.value,
    this.jsType,
  });

  /// json_serializable, handles both formats:
  ///  IETF: { "kind": "given", "value": "John" }
  ///  JSContact: { "@type": "NameComponent", "type": "given", "value": "John" }
  factory Components.fromJson(Map<String, dynamic> json) {
    return Components(
      kind: json['kind'] as String? ?? json['type'] as String?,
      value: json['value'] as String?,
      jsType: json['@type'] as String?,
    );
  }

  /// IETF serialization (ContactCard).
  Map<String, dynamic> toIetfJson() => <String, dynamic>{
        // IETF NameComponent uses 'kind'
        'kind': kind,
        'value': value,
      };

  /// JSContact serialization (Card).
  Map<String, dynamic> toJsContactJson() => <String, dynamic>{
        '@type': jsType ?? 'NameComponent',
        'type': kind,
        'value': value,
      };

  Map<String, dynamic> toVersionedJson(ContactApiVersion apiVersion) {
    switch (apiVersion) {
      case ContactApiVersion.ietf:
        return toIetfJson();
      default:
        return toJsContactJson();
    }
  }

  @override
  List<Object?> get props => [kind, value, jsType];

  @override
  String toString() => 'Components(kind: $kind, value: $value, jsType: $jsType)';
}
