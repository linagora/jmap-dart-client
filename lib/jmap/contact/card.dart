import 'package:jmap_dart_client/jmap/contact/speaak_to_as.dart';
import 'package:jmap_dart_client/jmap/contact/street.dart';
import 'contact.dart';
import 'contact_api_version.dart';
import 'package:jmap_dart_client/http/converter/contact/contact_id_nullable_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/address_value_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/organization_value_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/phone_value_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/email_value_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/title_value_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/related_to_value_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/anniversary_value_converter.dart';
import 'package:jmap_dart_client/jmap/contact/contact_ids.dart';
import 'package:jmap_dart_client/jmap/contact/address_values.dart';
import 'package:jmap_dart_client/jmap/contact/organization_values.dart';
import 'package:jmap_dart_client/jmap/contact/phone_values.dart';
import 'package:jmap_dart_client/jmap/contact/email_values.dart';
import 'package:jmap_dart_client/jmap/contact/title_values.dart';
import 'package:jmap_dart_client/jmap/contact/related_to_values.dart';
import 'package:jmap_dart_client/jmap/contact/anniversary_values.dart';
import 'package:jmap_dart_client/jmap/contact/name.dart';

// Represent the JSContact/Cyrus
class Card extends Contact {
  final String? uid;
  final String? type;
  String? fullName;
  final String? kind;
  final List<String>? nickNames;
  final Name? name;
  final Map<String, bool>? addressBookIds;
  final String? blobId;
  final Map<String, bool>? members;
  final String? prodId;
  final SpeakToAs? speakToAs;

  Card({
    ContactId? id,
    this.uid,
    this.type,
    this.fullName,
    String? created,
    String? updated,
    this.kind,
    this.nickNames,
    this.name,
    Map<OrganizationName, OrganizationValue>? organizations,
    Map<PhoneId, PhoneValue>? phones,
    Map<AnniversaryId, AnniversaryValue>? anniversaries,
    Map<RelatedToName, RelatedToValue>? relatedTo,
    Map<EmailId, EmailValue>? emails,
    Map<TitleId, TitleValue>? titles,
    Map<AddressId, AddressValue>? addresses,
    this.addressBookIds,
    this.blobId,
    this.members,
    this.prodId,
    this.speakToAs,
  }) : super(
          id: id?.id,
          created: created,
          updated: updated,
          emails: emails,
          phones: phones,
          addresses: addresses,
          organizations: organizations,
          relatedTo: relatedTo,
          titles: titles,
          anniversaries: anniversaries,
        ) {
    // Auto-generate fullName ONLY for JSContact and Cyrus style cards.
    if (fullName == null && name != null) {
      final generated = generateFullNameFromComponents();
      if (generated != null && generated.isNotEmpty) {
        fullName = generated;
      }
    }
   }

  /// Creates a Card from JSON using the selected API version.
  factory Card.fromJson(
    Map<String, dynamic> json, {
    required ContactApiVersion apiVersion,
  }) {
    if (apiVersion == ContactApiVersion.cyrus) {
      return Card.fromCyrusJson(json);
    }
    return _fromJsContactJson(json);
  }

  /// Builds a Card from Cyrus formatted JSON.
  static Card _fromJsContactJson(Map<String, dynamic> json) {
    return Card(
      id: const ContactIdNullableConverter().fromJson(json['id']),
      type: json['@type'] as String?,
      fullName: json['fullName'] as String?,
      created: json['created']?.toString(),
      updated: json['updated']?.toString(),
      kind: json['kind']?.toString(),
      nickNames: (json['nickNames'] as List?)?.cast<String>(),
      name: json['name'] is Map ? Name.fromJson(json['name']) : null,
      organizations: (json['organizations'] as Map<String, dynamic>?)
          ?.map((k, v) => OrganizationValueConverter().parseEntry(k, v, ContactApiVersion.jscontact)),
      phones: (json['phones'] as Map<String, dynamic>?)
          ?.map((k, v) => PhoneValueConverter().parseEntry(k, v)),
      anniversaries: (json['anniversaries'] as Map<String, dynamic>?)
          ?.map((k, v) => AnniversaryValueConverter().parseEntry(k, v)),
      relatedTo: (json['relatedTo'] as Map<String, dynamic>?)
          ?.map((k, v) => RelatedToValueConverter().parseEntry(k, v)),
      emails: (json['emails'] as Map<String, dynamic>?)
          ?.map((k, v) => EmailValueConverter().parseEntry(k, v)),
      titles: (json['titles'] as Map<String, dynamic>?)
          ?.map((k, v) => TitleValueConverter().parseEntry(k, v)),
      addresses: (json['addresses'] as Map<String, dynamic>?)
          ?.map((k, v) => AddressValueConverter().parseEntry(k, v)),
      addressBookIds: (json['addressBookIds'] as Map?)
          ?.map((k, v) => MapEntry(k.toString(), v == true)),
      blobId: json['blobId']?.toString(),
      members: (json['members'] as Map?)
          ?.map((k, v) => MapEntry(k.toString(), v == true)),
      prodId: json['prodId']?.toString(),
      speakToAs:
          json['speakToAs'] is Map ? SpeakToAs.fromJson(json['speakToAs']) : null,
    );
  }

  factory Card.fromCyrusJson(Map<String, dynamic> json) {
     final cyrusFullName = json['fullName']?.toString();
      final firstName = json['firstName']?.toString();
      final lastName = json['lastName']?.toString();

      String? fullName = cyrusFullName;

      if ((fullName == null || fullName.isEmpty) &&
          (firstName != null || lastName != null)) {
        final parts = <String>[];
        if (firstName != null && firstName.isNotEmpty) {
          parts.add(firstName);
        }
        if (lastName != null && lastName.isNotEmpty) {
          parts.add(lastName);
        }
        if (parts.isNotEmpty) {
          fullName = parts.join(' ');
        }
      }
    return Card(
      id: const ContactIdNullableConverter().fromJson(json['id']),
      uid: json['uid']?.toString(),
      prodId: json['prodId']?.toString(),
      created: json['created']?.toString(),
      updated: json['updated']?.toString(),
      kind: json['kind']?.toString(),
      nickNames:
          json['nickname'] != null ? [json['nickname'] as String] : null,
      fullName: fullName, 
      emails: _parseCyrusEmails(json),
      phones: _parseCyrusPhones(json),
      addresses: _parseCyrusAddresses(json),
      organizations: _parseCyrusOrganizations(json),
      anniversaries: _parseCyrusAnniversaries(json),
      blobId: json['blobId']?.toString(),
    );
  }

  static Map<EmailId, EmailValue> _parseCyrusEmails(Map json) {
    final list = (json['emails'] as List?) ?? [];

    return {
      for (int i = 0; i < list.length; i++)
        EmailId("email$i"): EmailValue(
          email: list[i]['value'], 
          type: list[i]['type']?.toString(),
        )
    };
  }


    static Map<PhoneId, PhoneValue> _parseCyrusPhones(Map json) {
    final list = (json['phones'] as List?) ?? [];

    return {
      for (int i = 0; i < list.length; i++)
        PhoneId("phone$i"): PhoneValue(
          phone: list[i]['value']?.toString(), 
          type: list[i]['type']?.toString(),
        )
    };
  }


  static Map<AddressId, AddressValue> _parseCyrusAddresses(Map json) {
    final list = (json['addresses'] as List?) ?? [];

    return {
      for (int i = 0; i < list.length; i++)
        AddressId("addr$i"): AddressValue(
          type: list[i]['type'],
          locality: list[i]['locality'],
          region: list[i]['region'],
          country: list[i]['country'],
          postcode: list[i]['postcode'],
          street: list[i]['street'] != null
              ? {
                  Street(
                    typeName: null,
                    type: null,
                    value: list[i]['street'].toString(),
                  )
                }
              : null,
        )
    };
  }


  static Map<OrganizationName, OrganizationValue> _parseCyrusOrganizations(
      Map json) {
    if (json['company'] == null) return {};
    return {
      OrganizationName("org1"): OrganizationValue(name: json['company'])
    };
  }

  static Map<AnniversaryId, AnniversaryValue> _parseCyrusAnniversaries(
      Map json) {
    if (json['anniversary'] == null) return {};
    return {
      AnniversaryId("a1"): AnniversaryValue(date: json['anniversary'])
    };
  }

  /// Serializes the contact to a JSON map following the JSContact structure
  @override
  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result['id'] = const ContactIdNullableConverter()
        .toJson(id == null ? null : ContactId(id!));
    result['@type'] = type;
    result['fullName'] = fullName;
    result['created'] = created;
    result['updated'] = updated;
    result['kind'] = kind;
    result['nickNames'] = nickNames;
    result['name'] = name?.toJson(ContactApiVersion.jscontact);
    result['addressBookIds'] = addressBookIds;
    result['blobId'] = blobId;
    result['members'] = members;
    result['prodId'] = prodId;
    result['speakToAs'] = speakToAs?.toJson();

    if (addresses != null) {
      result['addresses'] = {
        for (final e in addresses!.entries) e.key.value: e.value.toJson()
      };
    }

    if (phones != null) {
      result['phones'] = {
        for (final e in phones!.entries) e.key.value: e.value.toJson()
      };
    }

    result['emails'] = emails?.map(
      (k, v) => EmailValueConverter()
          .toJson(k, v, apiVersion: ContactApiVersion.jscontact),
    );

    if (organizations != null) {
      result['organizations'] = {
        for (final e in organizations!.entries)
          e.key.value: e.value.toVersionedJson(ContactApiVersion.jscontact)
      };
    }


    if (titles != null) {
      result['titles'] = {
        for (final e in titles!.entries) e.key.value: e.value.toLegacyJson()
      };
    }

    if (relatedTo != null) {
      result['relatedTo'] = {
        for (final e in relatedTo!.entries) e.key.value: e.value.toJson()
      };
    }

    if (anniversaries != null) {
      result['anniversaries'] = {
        for (final e in anniversaries!.entries) e.key.value: e.value.toJson()
      };
    }

    return result;
  }

  /// Converts the contact into a JSON format compatible with Cyrus.
  Map<String, dynamic> toCyrusJson() {
    final data = <String, dynamic>{};

    if (fullName != null && fullName!.trim().isNotEmpty) {
      final parts = fullName!.trim().split(RegExp(r'\s+'));
      data['firstName'] = parts.first;
      if (parts.length > 1) data['lastName'] = parts.sublist(1).join(' ');
    }

    if (emails != null && emails!.isNotEmpty) {
      data['emails'] = emails!.values.map((e) {
        return {'type': e.type ?? 'work', 'value': e.email ?? ''};
      }).toList();
    }

    if (phones != null && phones!.isNotEmpty) {
      data['phones'] = phones!.values.map((p) {
        return {'type': p.type ?? 'mobile', 'value': p.phone ?? ''};
      }).toList();
    }

      if (addresses != null && addresses!.isNotEmpty) {
      data['addresses'] = addresses!.values.map((a) {
        String? streetText;
        if (a.street != null && a.street!.isNotEmpty) {
          streetText = a.street!
              .map((s) => s.value?.trim())
              .where((s) => s != null && s.isNotEmpty)
              .join(', ');
        }

      return {
            'type': a.type ?? 'home', 
            if (streetText != null && streetText.isNotEmpty) 'street': streetText,
            if (a.locality != null && a.locality!.isNotEmpty)
              'locality': a.locality,
            if (a.region != null && a.region!.isNotEmpty) 'region': a.region,
            if (a.postcode != null && a.postcode!.isNotEmpty)
              'postcode': a.postcode,
            if (a.country != null && a.country!.isNotEmpty) 'country': a.country,
          };
        }).toList();
      }
      if (titles != null && titles!.isNotEmpty) {
      final title = titles!.values.first;
        data['jobTitle'] = title;
      }

    if (organizations != null && organizations!.isNotEmpty) {
      final org = organizations!.values.first;
      if (org.name != null) data['company'] = org.name;
    }

    if (anniversaries != null && anniversaries!.isNotEmpty) {
      final anniv = anniversaries!.values.first;
      if (anniv.date != null) data['anniversary'] = anniv.date;
    }
    return data;
  }


  /// Builds a full name by combining given and surname components.
  String? generateFullNameFromComponents() {
    if (name == null || name!.components == null) return null;

    final given = name!.components!
        .where((c) => c.kind == 'given')
        .map((c) => c.value ?? '')
        .join(' ')
        .trim();

    final sur = name!.components!
        .where((c) => c.kind == 'surname')
        .map((c) => c.value ?? '')
        .join(' ')
        .trim();

    if (given.isEmpty && sur.isEmpty) return null;
    return "$given $sur".trim();
  }
 @override
  List<Object?> get props => [
        id,
        created,
        updated,
        emails,
        phones,
        addresses,
        organizations,
        relatedTo,
        titles,
        anniversaries,
        uid,
        type,
        fullName,
        kind,
        nickNames,
        name,
        addressBookIds,
        blobId,
        members,
        prodId,
        speakToAs,
      ];

  @override
  String toString() {
    return 'Card('
        'id: $id, '
        'fullName: $fullName, '
        'created: $created, '
        'updated: $updated, '
        'nickNames: $nickNames, '
        'emails: $emails, '
        'phones: $phones, '
        'addresses: $addresses, '
        'organizations: $organizations, '
        'anniversaries: $anniversaries, ' 
        'relatedTo: $relatedTo, '
        'titles: $titles, '
        'uid: $uid, '
        'type: $type, '
        'kind: $kind, '
        'name: $name, '
        'addressBookIds: $addressBookIds, '
        'blobId: $blobId, '
        'members: $members, '
        'prodId: $prodId, '
        'speakToAs: $speakToAs'
        ')';
  }
}
