import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/contact/context_value_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/phone_features_type_converter.dart';
import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/contact/context.dart';
import 'package:jmap_dart_client/jmap/contact/phone_features_identifier.dart';

class PhoneValue with EquatableMixin {
  final String? type;     
  final String? phone;    // Cyrus Contact
  final Map<PhoneFeature, bool>? features;
  final Map<Context, bool>? contexts;
  final String? number;   // IETF / JSContact ContactCard
  final int? pref;
  final String? label;

  PhoneValue({
    this.type,
    this.phone,
    this.features,
    this.contexts,
    this.number,
    this.pref,
    this.label,
  });

  factory PhoneValue.fromJson(Map<String, dynamic> json) {
    return PhoneValue(
      type: json['@type'] as String?,
      phone: json['phone'] as String?,
      features: (json['features'] as Map<String, dynamic>?)
          ?.map((k, v) => PhoneFeaturesConverter().parseEntry(k, v)),
      contexts: (json['contexts'] as Map<String, dynamic>?)
          ?.map((k, v) => ContextConverter().parseEntry(k, v)),
      number: json['number'] as String?,
      pref: json['pref'] as int?,
      label: json['label'] as String?,
    );
  }

  // Cyrus Contact JSON
  Map<String, dynamic> toCyrusJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) val[key] = value;
    }

    writeNotNull('@type', type ?? 'Phone');
    writeNotNull('phone', phone ?? number);
    writeNotNull(
      'features',
      features?.map((k, v) => PhoneFeaturesConverter().toJson(k, v)),
    );
    writeNotNull(
      'contexts',
      contexts?.map((k, v) => ContextConverter().toJson(k, v)),
    );
    writeNotNull('pref', pref);
    writeNotNull('label', label);
    return val;
  }

  // IETF/JSContact ContactCard JSON
  Map<String, dynamic> toJsContactJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) val[key] = value;
    }
    writeNotNull('@type', type ?? 'Phone');
    writeNotNull('number', number ?? phone);
    writeNotNull(
      'features',
      features?.map((k, v) => PhoneFeaturesConverter().toJson(k, v)),
    );
    writeNotNull(
      'contexts',
      contexts?.map((k, v) => ContextConverter().toJson(k, v)),
    );
    writeNotNull('pref', pref);
    writeNotNull('label', label);
    return val;
  }

  Map<String, dynamic> toVersionedJson(ContactApiVersion apiVersion) =>
      apiVersion == ContactApiVersion.ietf ? toJsContactJson() : toCyrusJson();

  @override
  List<Object?> get props =>
      [type, phone, features, contexts, number, pref, label];

 @override
  String toString() {
    final parts = <String>[];

    if (type != null) {
      parts.add('type: $type');
    }

    // Use Cyrus if phone is set, otherwise IETF / JSContactview.
    if (phone != null) {
      parts.add('phone: $phone');
    } else if (number != null) {
      parts.add('number: $number');
    }

    if (features != null) {
      parts.add('features: $features');
    }
    if (contexts != null) {
      parts.add('contexts: $contexts');
    }
    if (pref != null) {
      parts.add('pref: $pref');
    }
    if (label != null) {
      parts.add('label: $label');
    }

    return 'PhoneValue(${parts.join(', ')})';
  }
}

