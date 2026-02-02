import 'package:jmap_dart_client/http/converter/contact/anniversary_value_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/language_preference_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/note_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/online_service_converter.dart';
import 'package:jmap_dart_client/jmap/contact/contact.dart';
import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/contact/crypto_key.dart';
import 'package:jmap_dart_client/jmap/contact/directory.dart';
import 'package:jmap_dart_client/jmap/contact/language_preference.dart';
import 'package:jmap_dart_client/jmap/contact/media.dart';
import 'package:jmap_dart_client/jmap/contact/name.dart';
import 'package:jmap_dart_client/http/converter/contact/email_value_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/phone_value_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/address_value_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/organization_value_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/related_to_value_converter.dart';
import 'package:jmap_dart_client/http/converter/contact/title_value_converter.dart';
import 'package:jmap_dart_client/jmap/contact/nicknames.dart';
import 'package:jmap_dart_client/jmap/contact/note.dart';
import 'package:jmap_dart_client/jmap/contact/online_service_values.dart';
import 'package:jmap_dart_client/jmap/contact/personal_info.dart';
import 'package:jmap_dart_client/jmap/contact/scheduling_address.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';

/// IETF ContactCard
class ContactCard extends Contact {
  final Map<String, bool>? addressBookIds;
  final Name? name;
  final String? blobId;
  final Map<String, Nickname>? nicknames;
  final Map<String, OnlineServiceValue>? onlineServices;
  final Map<String, LanguagePref>? preferredLanguages;
  final Map<String, bool>? keywords;
  final Map<String, Note>? notes;
  final Map<String, SchedulingAddress>? schedulingAddresses;
  final Map<String, Directory>? directories;
  final Map<String, Media>? media;
  final Map<String, CryptoKey>? cryptoKeys;
  final Map<String, Map<String, dynamic>>? localizations;
  final Map<String, PersonalInfo>? personalInfo;

  ContactCard({
    super.id,
    super.created,
    super.updated,
    super.emails,
    super.phones,
    super.addresses,
    super.organizations,
    super.relatedTo,
    super.titles,
    super.anniversaries,
    this.addressBookIds,
    this.name,
    this.blobId,
    this.nicknames,
    this.onlineServices,
    this.preferredLanguages,
    this.keywords,
    this.notes,
    this.schedulingAddresses,
    this.directories,
    this.media,
    this.cryptoKeys,
    this.localizations,
    this.personalInfo,
  });

  /// Creates a ContactCard from a IETF formatted JSON map.
  factory ContactCard.fromJson(Map<String, dynamic> json) {
    return ContactCard(
      id: json['id'] != null ? Id(json['id']) : null,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
      name: json['name'] != null ? Name.fromJson(json['name']) : null,
      blobId: json['blobId']?.toString(),
      addressBookIds: (json['addressBookIds'] as Map?)
          ?.map((k, v) => MapEntry(k.toString(), v == true)),
      emails: (json['emails'] as Map<String, dynamic>?)
          ?.map((k, v) => EmailValueConverter().parseEntry(k, v)),
      phones: (json['phones'] as Map?)
          ?.map((k, v) =>
              PhoneValueConverter().parseEntry(k.toString(), v)),
      addresses: (json['addresses'] as Map<String, dynamic>?)
          ?.map((k, v) => AddressValueConverter().parseEntry(k, v)),
      organizations: (json['organizations'] as Map<String, dynamic>?)
          ?.map((k, v) => OrganizationValueConverter().parseEntry(k, v, ContactApiVersion.ietf)),
      relatedTo: (json['relatedTo'] as Map<String, dynamic>?)
          ?.map((k, v) => RelatedToValueConverter().parseEntry(k, v)),
      titles: (json['titles'] as Map<String, dynamic>?)
          ?.map((k, v) => TitleValueConverter().parseEntry(k, v)),
      anniversaries:
        (json['anniversaries'] as Map<String, dynamic>?)?.map(
        (k, v) => AnniversaryValueConverter().parseEntry(k, v),
      ),
      nicknames: (json['nicknames'] as Map<String, dynamic>?)
          ?.map((k, v) => MapEntry(k, Nickname.fromJson(v))),
      onlineServices: (json['onlineServices'] as Map<String, dynamic>?)
          ?.map((k, v) => OnlineServiceValueConverter().parseEntry(k, v)),
      preferredLanguages: (json['preferredLanguages'] as Map<String, dynamic>?)
          ?.map((k, v) => LanguagePrefConverter().parseEntry(k, v)),
      keywords: (json['keywords'] as Map?)
          ?.map((k, v) => MapEntry(k.toString(), v == true)),
      notes: (json['notes'] as Map<String, dynamic>?)
          ?.map((k, v) => NoteValueConverter().parseEntry(k, v)),
      schedulingAddresses:
        (json['schedulingAddresses'] as Map<String, dynamic>?)
            ?.map((k, v) => MapEntry(
                  k,
                  SchedulingAddress.fromJson(v as Map<String, dynamic>),
                )),
      directories: (json['directories'] as Map<String, dynamic>?)?.map(
        (k, v) => MapEntry(
          k,
          Directory.fromJson(v as Map<String, dynamic>),
        ),
      ),
      media: (json['media'] as Map<String, dynamic>?)?.map(
        (k, v) => MapEntry(
          k,
          Media.fromJson(v as Map<String, dynamic>),
        ),
      ),
      cryptoKeys: (json['cryptoKeys'] as Map<String, dynamic>?)?.map(
        (k, v) => MapEntry(
          k,
          CryptoKey.fromJson(v as Map<String, dynamic>),
        ),
      ),
      localizations: (json['localizations'] as Map<String, dynamic>?)
      ?.map((lang, value) => MapEntry(lang, Map<String, dynamic>.from(value))),
      personalInfo: (json['personalInfo'] as Map<String, dynamic>?)?.map(
        (k, v) => MapEntry(
          k,
          PersonalInfo.fromJson(v as Map<String, dynamic>),
        ),
      ),
    );
  }

  /// Validates and removes unsupported fields for IETF ContactCard objects.
  ///
  /// This ensures compliance with the IETF JMAP Contacts specification (RFC 9553).
  /// The IETF version does not support certain fields that are valid in JSContact,
  /// such as [fullName] and [nickNames]. Attempting to send these fields will result
  /// in an "Invalid property" error.
  ///
  /// Additionally, [addressBookIds] is required when creating or updating
  /// ContactCard objects under the IETF schema, whereas it is optional in JSContact.
  void validateAndRemoveIetfFields(Map<String, dynamic> json) {
    final unsupported = <String>[];

    // Required by IETF JMAP Contacts
    if (addressBookIds == null || addressBookIds!.isEmpty) {
      throw ArgumentError(
        '[IETF ContactCard Error] "addressBookIds" is required for IETF ContactCard objects.',
      );
    }

    // Remove unsupported / wrong fields from JSON data
    if (json.containsKey('fullName')) {
      unsupported.add('fullName');
      json.remove('fullName');
    }
    if (json.containsKey('speakToAs')) {
      unsupported.add('speakToAs');
      json.remove('speakToAs');
    }
    if (json.containsKey('kind')) {
      unsupported.add('kind');
      json.remove('kind');
    }
    if (json.containsKey('members')) {
      unsupported.add('members');
      json.remove('members');
    }
    if (json.containsKey('prodId')) {
      unsupported.add('prodId');
      json.remove('prodId');
    }
    if (json.containsKey('@type')) {
      unsupported.add('@type');
      json.remove('@type');
    }

    if (unsupported.isNotEmpty) {
      assert(() {
        // ignore: avoid_print
        print(
          '[IETF ContactCard Warning] Ignored non-standard fields: '
          '${unsupported.join(', ')}',
        );
        return true;
      }());
    }
  }

  /// Serializes the ContactCard into a JSON map.
  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (id != null) map['id'] = id!.value;
    map['created'] = created;
    map['updated'] = updated;
    map['name'] = name?.toJson(ContactApiVersion.ietf);
    map['addressBookIds'] = addressBookIds;
    map['blobId'] = blobId;

    map['emails'] = emails?.map(
      (k, v) =>
          EmailValueConverter().toJson(k, v, apiVersion: ContactApiVersion.ietf),
    );

    map['phones'] = phones?.map(
      (k, v) => PhoneValueConverter().toJson(k, v, apiVersion: ContactApiVersion.ietf),
    );


    map['addresses'] = addresses?.map(
      (k, v) => AddressValueConverter().toJson(k, v, apiVersion: ContactApiVersion.ietf),
    );

    map['organizations'] = organizations?.map(
      (k, v) => OrganizationValueConverter().toJson(
        k,
        v,
        apiVersion: ContactApiVersion.ietf),
    );

    map['relatedTo'] = relatedTo?.map(
      (k, v) => RelatedToValueConverter().toJson(k, v),
    );

    map['titles'] = titles?.map(
      (k, v) => TitleValueConverter().toJson(k, v),
    );

    map['nicknames'] = nicknames?.map(
      (k, v) => MapEntry(k, v.toJson()),
    );

    map['onlineServices'] = onlineServices?.map(
      (k, v) => OnlineServiceValueConverter().toJson(
        k,
        v,
        apiVersion: ContactApiVersion.ietf,
      ),
    );

    map['preferredLanguages'] = preferredLanguages?.map(
      (k, v) => LanguagePrefConverter().toJson(
        k,
        v,
        apiVersion: ContactApiVersion.ietf,
      ),
    );
    map['keywords'] = keywords;

    map['notes'] = notes?.map(
      (k, v) => NoteValueConverter().toJson(
        k,
        v,
        apiVersion: ContactApiVersion.ietf,
      ),
    );
    map['schedulingAddresses'] = schedulingAddresses?.map(
      (k, v) => MapEntry(k, v.toJson()),
    );
    map['directories'] = directories?.map(
      (k, v) => MapEntry(k, v.toJson()),
    );
    map['media'] = media?.map(
      (k, v) => MapEntry(k, v.toJson()),
    );
    map['cryptoKeys'] = cryptoKeys?.map(
      (k, v) => MapEntry(k, v.toJson()),
    );
    map['localizations'] = localizations?.map(
      (lang, inner) => MapEntry(
        lang,
        inner.map((ptr, v) => MapEntry(ptr, v.toJson())),
      ),
    );
    map['personalInfo'] = personalInfo?.map(
      (k, v) => MapEntry(
        k,
        v.toJson(),
      ),
    );
    map['anniversaries'] = anniversaries?.map(
      (k, v) => AnniversaryValueConverter().toJson(k, v),
    );
    validateAndRemoveIetfFields(map);
    return map;
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
        addressBookIds,
        name,
        blobId,
        nicknames,
        onlineServices,
        preferredLanguages,
        anniversaries,
        keywords,
        notes,
        schedulingAddresses, 
        directories,
        media,
        cryptoKeys,
        localizations,
        personalInfo,
        anniversaries
      ];

  @override
  String toString() {
    return 'ContactCard('
        'id: $id, '
        'created: $created, '
        'updated: $updated, '
        'name: $name, '
        'addressBookIds: $addressBookIds, '
        'emails: $emails, '
        'phones: $phones, '
        'addresses: $addresses, '
        'organizations: $organizations, '
        'titles: $titles, '
        'nicknames: $nicknames, '
        'onlineServices: $onlineServices, '
        'preferredLanguages: $preferredLanguages, '
        'keywords: $keywords, '
        'notes: $notes, '
        'blobId: $blobId'
        'schedulingAddresses: $schedulingAddresses'
        'directories: $directories'
        'media: $media'
        'cryptoKeys: $cryptoKeys'
        'localizations: $localizations'
        'personalInfo: $personalInfo'
        'anniversaries: $anniversaries'
        ')';
  }
}
