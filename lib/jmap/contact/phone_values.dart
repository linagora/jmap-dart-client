import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/http/converter/contact/phone_features_type_converter.dart';
import 'package:jmap_dart_client/jmap/contact/phone_features_identifier.dart';
import 'package:jmap_dart_client/http/converter/contact/phone_feature_value_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/phone_features_value_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/context_value_converter.dart';
import 'package:jmap_dart_client/jmap/contact/context.dart';
import 'package:jmap_dart_client/http/converter/contact/context_nullable_converter.dart';

@ContextValueNullableConverter()
@PhoneFeatureValueNullableConverter()
@PhoneFeatureValueConverter()

class PhoneValue with EquatableMixin {

  @JsonKey(includeIfNull: false)
  final String? type;

  @JsonKey(includeIfNull: false)
  final String? phone;

  final Map<PhoneFeature, bool>? features;

  final Map<Context, bool>? contexts;

  @JsonKey(includeIfNull: false)
  final String? number;

  @JsonKey(includeIfNull: false)
  final int? pref;

  @JsonKey(includeIfNull: false)
  final String? label;

  PhoneValue({this.type, this.phone, this.features, this.contexts, this.number, this.pref, this.label});

  factory PhoneValue.fromJson(Map<String, dynamic> json) => _$PhoneValueFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneValueToJson(this);

  @override
  List<Object?> get props => [type, phone, features, contexts, number, pref, label];

  @override
  String toString() {
    return 'PhoneValue('
        'type: $type, '
        'phone: $phone, '
        'features: $features, '
        'contexts: $contexts, '
        'number: $number, '
        'pref: $pref, '
        'label: $label'
        ')';
  }
}

PhoneValue _$PhoneValueFromJson(Map<String, dynamic> json) => PhoneValue(
    type : json['@type'] as String?,
    phone: json['phone'] as String?,
    features: (json['features'] as Map<String, dynamic>?)?.map((key, value) =>  PhoneFeaturesConverter().parseEntry(key, value)),
    contexts: (json['contexts'] as Map<String, dynamic>?)?.map((key, value) =>   ContextConverter().parseEntry(key, value)),
    number: json['number'] as String?,
    pref: json['pref'] as int?,
    label: json['label'] as String?,
);

Map<String, dynamic> _$PhoneValueToJson(PhoneValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  writeNotNull('phone', instance.phone);
  writeNotNull('features', instance.features?.map((key, value) =>  PhoneFeaturesConverter().toJson(key, value)));
  writeNotNull('contexts', instance.contexts?.map((key, value) =>   ContextConverter().toJson(key, value)));
  writeNotNull('number', instance.number);
  writeNotNull('pref', instance.pref);
  writeNotNull('label', instance.label);
  return val;
}


