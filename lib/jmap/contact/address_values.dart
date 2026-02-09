import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/contact/context_value_converter.dart';
import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/contact/context.dart';
import 'package:jmap_dart_client/jmap/contact/street.dart';

class AddressValue with EquatableMixin {
  final String? type;         
  final String? locality;     
  final String? region;       
  final String? country;      
  final String? postcode;     
  final String? coordinates;   
  final String? timeZone;      
  final int? pref;            
  final String? label;         
  final Map<Context, bool>? contexts;
  final Set<Street>? street;  
  final List<Map<String, String>>? components;  
  final String? countryCode;  
  final String? full;          
  final String? defaultSeparator; 
  final bool? isOrdered;       

  AddressValue({
    this.type = 'Address',
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

  factory AddressValue.fromJson(Map<String, dynamic> json) {
    return AddressValue(
      type: json['@type'] as String?,
      locality: json['locality'] as String?,
      region: json['region'] as String?,
      country: json['country'] as String?,
      postcode: json['postcode'] as String?,
      coordinates: json['coordinates'] as String?,
      timeZone: json['timeZone'] as String?,
      pref: (json['pref'] is int)
          ? json['pref'] as int
          : (json['pref'] is String ? int.tryParse(json['pref'] as String) : null),
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
  }

  // JSContact / IETF JSON (RFC 9553 Address object)
  Map<String, dynamic> toJsContactJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) val[key] = value;
    }

    writeNotNull('@type', type ?? 'Address');
    writeNotNull('components', components);
    writeNotNull('countryCode', countryCode);
    writeNotNull('full', full);
    writeNotNull('defaultSeparator', defaultSeparator);
    writeNotNull('isOrdered', isOrdered);
    writeNotNull('coordinates', coordinates);
    writeNotNull('timeZone', timeZone);
    writeNotNull(
      'contexts',
      contexts?.map((k, v) => ContextConverter().toJson(k, v)),
    );
    writeNotNull('pref', pref);
    writeNotNull('label', label);
    writeNotNull('locality', locality);
    writeNotNull('region', region);
    writeNotNull('country', country);
    writeNotNull('postcode', postcode);

    return val;
  }

  // Cyrus JSON 
  Map<String, dynamic> toCyrusJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) val[key] = value;
    }

    writeNotNull('type', type);
    if (street != null && street!.isNotEmpty) {
      final streetText = street!
          .map((s) => s.value?.trim())
          .where((s) => s != null && s.isNotEmpty)
          .join(', ');
      writeNotNull('street', streetText);
    }
    writeNotNull('locality', locality);
    writeNotNull('region', region);
    writeNotNull('postcode', postcode);
    writeNotNull('country', country);
    return val;
  }

  Map<String, dynamic> toVersionedJson(ContactApiVersion apiVersion) {
    switch (apiVersion) {
      case ContactApiVersion.ietf:
      case ContactApiVersion.jscontact:
        return toJsContactJson();
      case ContactApiVersion.cyrus:
        return toCyrusJson();
    }
  }

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
    final parts = <String>[];

    if (type != null) {
      parts.add('type: $type');
    }

    // Prefer JSContact/IETF representation if components exist
    if (components != null && components!.isNotEmpty) {
      parts.add('components: $components');
      if (countryCode != null) parts.add('countryCode: $countryCode');
      if (full != null) parts.add('full: $full');
      if (defaultSeparator != null) {
        parts.add('defaultSeparator: $defaultSeparator');
      }
      if (isOrdered != null) parts.add('isOrdered: $isOrdered');
    } else {
      // Cyrus style if no components
      if (street != null && street!.isNotEmpty) {
        parts.add('street: $street');
      }
      if (locality != null) parts.add('locality: $locality');
      if (region != null) parts.add('region: $region');
      if (postcode != null) parts.add('postcode: $postcode');
      if (country != null) parts.add('country: $country');
    }

    if (coordinates != null) parts.add('coordinates: $coordinates');
    if (timeZone != null) parts.add('timeZone: $timeZone');
    if (contexts != null) parts.add('contexts: $contexts');
    if (pref != null) parts.add('pref: $pref');
    if (label != null) parts.add('label: $label');

    return 'AddressValue(${parts.join(', ')})';
  }

}
