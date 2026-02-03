import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/contact/street.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/http/converter/contact/related_to_relation_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/address_id_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/context_value_converter.dart';
import 'context.dart';

@RelationValueNullableConverter()
@AddressIdConverter()
class AddressValue with EquatableMixin {
  @JsonKey(includeIfNull: false)
  final String? type;

  @JsonKey(includeIfNull: false)
  final String? locality;

  @JsonKey(includeIfNull: false)
  final String? region;

  @JsonKey(includeIfNull: false)
  final String? country;

  @JsonKey(includeIfNull: false)
  final String? postcode;

  @JsonKey(includeIfNull: false)
  final String? coordinates;

  @JsonKey(includeIfNull: false)
  final String? timeZone;

  @JsonKey(includeIfNull: false)
  final String? pref;

  @JsonKey(includeIfNull: false)
  final String? label;

  final Map<Context, bool>? contexts;

  @JsonKey(includeIfNull: false)
  Set<Street>? street;

  @JsonKey(includeIfNull: false)
  final List<Map<String, String>>? components; 

  @JsonKey(includeIfNull: false)
  final String? countryCode;

  @JsonKey(includeIfNull: false)
  final String? full;

  @JsonKey(includeIfNull: false)
  final String? defaultSeparator;

  @JsonKey(includeIfNull: false)
  final bool? isOrdered;

  AddressValue({
    this.type,
    this.locality,
    this.region,
    this.country,
    this.postcode,
    this.coordinates,
    this.timeZone,
    this.pref,
    this.label,
    this.contexts,
    this.street,
    this.components,
    this.countryCode,
    this.full,
    this.defaultSeparator,
    this.isOrdered,
  });

  factory AddressValue.fromJson(Map<String, dynamic> json) => _$AddressValueFromJson(json);

  Map<String, dynamic> toJson() => _$AddressValueToJson(this);

  @override
  List<Object?> get props => [
        type,
        locality,
        region,
        country,
        postcode,
        coordinates,
        timeZone,
        pref,
        label,
        contexts,
        street,
        components,
        countryCode,
        full,
        defaultSeparator,
        isOrdered,
      ];
      
  @override
  String toString() {
    return 'AddressValue('
        'type: $type, '
        'locality: $locality, '
        'region: $region, '
        'country: $country, '
        'postcode: $postcode, '
        'coordinates: $coordinates, '
        'timeZone: $timeZone, '
        'pref: $pref, '
        'label: $label, '
        'contexts: $contexts, '
        'street: $street, '
        'components: $components, '
        'countryCode: $countryCode, '
        'full: $full, '
        'defaultSeparator: $defaultSeparator, '
        'isOrdered: $isOrdered'
        ')';
  }
}

AddressValue _$AddressValueFromJson(Map<String, dynamic> json) => AddressValue(
      type: json['@type'] as String?,
      locality: json['locality'] as String?,
      region: json['region'] as String?,
      country: json['country'] as String?,
      postcode: json['postcode'] as String?,
      coordinates: json['coordinates'] as String?,
      timeZone: json['timeZone'] as String?,
      pref: json['pref'] as String?,
      label: json['label'] as String?,
      contexts: (json['contexts'] as Map<String, dynamic>?)?.map(
        (key, value) => ContextConverter().parseEntry(key, value),
      ),
      street: (json['street'] as List<dynamic>?)
          ?.map((e) => Street.fromJson(e as Map<String, dynamic>))
          .toSet(),
      components: (json['components'] as List<dynamic>?)
          ?.whereType<Map<String, dynamic>>()
          .map((e) => {
                'kind': e['kind'] as String? ?? '',
                'value': e['value'] as String? ?? '',
              })
          .toList(),
      countryCode: json['countryCode'] as String?,
      full: json['full'] as String?,
      defaultSeparator: json['defaultSeparator'] as String?,
      isOrdered: json['isOrdered'] as bool?,
    );

Map<String, dynamic> _$AddressValueToJson(AddressValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  writeNotNull('locality', instance.locality);
  writeNotNull('region', instance.region);
  writeNotNull('country', instance.country);
  writeNotNull('postcode', instance.postcode);
  writeNotNull('coordinates', instance.coordinates);
  writeNotNull('timeZone', instance.timeZone);
  writeNotNull('pref', instance.pref);
  writeNotNull('label', instance.label);
  writeNotNull(
    'contexts',
    instance.contexts
        ?.map((key, value) => ContextConverter().toJson(key, value)),
  );
  writeNotNull('street', instance.street?.toList());

  // IETF-only address 
  writeNotNull('components', instance.components);
  writeNotNull('countryCode', instance.countryCode);
  writeNotNull('full', instance.full);
  writeNotNull('defaultSeparator', instance.defaultSeparator);
  writeNotNull('isOrdered', instance.isOrdered);

  return val;
}
