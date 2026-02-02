import 'package:flutter_test/flutter_test.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/contact/address_values.dart';
import 'package:jmap_dart_client/jmap/contact/anniversary_values.dart';
import 'package:jmap_dart_client/jmap/contact/author.dart';
import 'package:jmap_dart_client/jmap/contact/components.dart';
import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/contact/contact_card.dart';
import 'package:jmap_dart_client/jmap/contact/context.dart';
import 'package:jmap_dart_client/jmap/contact/crypto_key.dart';
import 'package:jmap_dart_client/jmap/contact/directory.dart';
import 'package:jmap_dart_client/jmap/contact/email_values.dart';
import 'package:jmap_dart_client/jmap/contact/language_preference.dart';
import 'package:jmap_dart_client/jmap/contact/localizations.dart';
import 'package:jmap_dart_client/jmap/contact/media.dart';
import 'package:jmap_dart_client/jmap/contact/name.dart';
import 'package:jmap_dart_client/jmap/contact/name_sort_as.dart';
import 'package:jmap_dart_client/jmap/contact/nicknames.dart';
import 'package:jmap_dart_client/jmap/contact/note.dart';
import 'package:jmap_dart_client/jmap/contact/online_service_values.dart';
import 'package:jmap_dart_client/jmap/contact/contact_ids.dart';
import 'package:jmap_dart_client/jmap/contact/organization_unit.dart';
import 'package:jmap_dart_client/jmap/contact/organization_values.dart';
import 'package:jmap_dart_client/jmap/contact/phone_features_identifier.dart';
import 'package:jmap_dart_client/jmap/contact/phone_values.dart';
import 'package:jmap_dart_client/jmap/contact/related_to_relation.dart';
import 'package:jmap_dart_client/jmap/contact/related_to_values.dart';
import 'package:jmap_dart_client/jmap/contact/scheduling_address.dart';
import 'package:jmap_dart_client/jmap/contact/title_values.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/util/contact_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  group('IETF ContactCard with all properties - Live Round-Trip Tests', () {
    late HttpClient httpClient;
    late AccountId accountId;

    setUp(() async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );
      httpClient = client.httpClient;
      accountId = client.accountId;
    });

    test('roundtrip: create contact -> get contact -> update contact -> delete contact (notFound) [IETF]', () async {
      final contact = ContactCard(
        addressBookIds: {'b': true},
        nicknames: {
          '123': Nickname(name: 'Peppy'),
        },
        name: Name(
          components: {
            Components(kind: 'given', value: 'Pepa'),
            Components(kind: 'given2', value: 'Jane'),
            Components(kind: 'surname', value: 'Pig'),
            Components(kind: 'surname2', value: 'Heavens'),
          },
          isOrdered: true,
          full: 'Ms. Pepa Jane Pig Heavens',
          sortAs: NameSortAs(
            surname: 'Pig Heavens',
            given: 'Pepa',
          ),
        ),
        emails: {
          EmailId('1'): EmailValue(
            type: "EmailAddress",
            email: 'jqpublic@xyz.example.com',
            contexts: {Context('work'): true},
            label: 'Work',
            pref: 1,
          ),
          EmailId('2'): EmailValue(
            type: "EmailAddress",
            email: 'jane_doe@example.com',
            pref: 1,
            contexts: {Context('private'): true}, 
            label: 'Home',
          ),
        },
        phones: {
          PhoneId('tel0'): PhoneValue(
            type: 'home',
            number: 'tel:+1-555-555-5555;ext=5555',
             features: {
              PhoneFeature.voice: true,
            },
            contexts: {Context('private'): true},
            pref: 1,
          ),
          PhoneId('tel3'): PhoneValue(
            type: 'work',
            number: 'tel:+1-201-555-0123',
            contexts: {Context('work'): true},
          ),
        },
        addresses: {
          AddressId('k23'): AddressValue(
            type: 'home',
            contexts: {Context('work'): true},
            components: [
              {'kind': 'number', 'value': '54321'},
              {'kind': 'separator', 'value': ' '},
              {'kind': 'name', 'value': 'Oak St'},
              {'kind': 'locality', 'value': 'Reston'},
              {'kind': 'region', 'value': 'VA'},
              {'kind': 'separator', 'value': ' '},
              {'kind': 'postcode', 'value': '20190'},
              {'kind': 'country', 'value': 'USA'},
            ],
            countryCode: 'US',
            full: '54321 Oak St, Reston, VA 20190, USA',
            coordinates: '38.9687,-77.3411',
            defaultSeparator: ', ',
            isOrdered: true,
          ),
        },
        localizations: {
          'jp': {
            'addresses/k26': LocalizedAddress(
              components: [
                {'kind': 'region', 'value': 'teito'},
                {'kind': 'separator', 'value': ''},
                {'kind': 'locality', 'value': 'chiyoda-ku'},
                {'kind': 'separator', 'value': ''},
                {'kind': 'street', 'value': '1-1-1 Chiyoda'},
                {'kind': 'separator', 'value': ''},
                {'kind': 'postcode', 'value': '100-0001'},
                {'kind': 'separator', 'value': ''},
                {'kind': 'country', 'value': 'Japan'},],
              defaultSeparator: '',
              full: 'Test full address',
              isOrdered: true,
            ),
          },
        },
        organizations: {
          OrganizationName('org1'): OrganizationValue(
            type: 'OrgUnit',
            name: 'Pig Enterprises GmbH',
          ),
          OrganizationName('o1'): OrganizationValue(
            type: 'OrgUnit',
            name: 'ABC, Inc.',
            units: [
              OrganizationUnit(name: 'North American Division'),
              OrganizationUnit(name: 'Marketing'),
            ],
            sortAs: 'ABC',
          ),
        },
        titles: {
          TitleId('le9'): TitleValue(
            type: 'title',
            kind: 'title',
            name: 'Research Scientist',
          ),
          TitleId('k2'): TitleValue(
            type: 'title',
            kind: 'role',
            name: 'Project Leader',
            organizationId: 'o2',
          ),
        },
        onlineServices: {
          'os1': OnlineServiceValue(
            service: 'Twitter',
            uri: 'https://twitter.com/pepapig',
            user: '@pepapig',
            label: 'Work Twitter',
            contexts: {Context('work'): true},
          ),
          'os2': OnlineServiceValue(
            service: 'LinkedIn',
            uri: 'https://linkedin.com/in/pepapig',
            user: 'pepapig',
            label: 'Work LinkedIn',
            contexts: {Context('work'): true},
          ),
        },
        preferredLanguages: {
          'l1': LanguagePref(
            language: 'en',
            contexts: {Context('work'): true},
            pref: 1,
          ),
          'l2': LanguagePref(
            language: 'fr',
            contexts: {Context('work'): true},
            pref: 2,
          ),
          'l3': LanguagePref(
            language: 'fr',
            contexts: {Context('private'): true},
            pref: 3,
          ),
        },
        keywords: const {
          'internet': true,
          'IETF': true,
        },
        notes: {
          'n1': Note(
            note: 'Open office hours are 1600 to 1715 EST, Mon-Fri',
            created: '2022-11-23T15:01:32Z',
            author: Author(
              name: 'John',
            ),
          ),
        },
        relatedTo: {
          RelatedToName('urn:uuid:f81d4fae-7dec-11d0-a765-00a0c91e6bf6'):
              RelatedToValue(
            type: 'Relation',
            relation: {
              Relation.friend: true,
            },
          ),
          RelatedToName('8cacdfb7d1ffdb59@example.com'): RelatedToValue(
            type: 'Relation',
            relation: const {},
          ),
        },
        schedulingAddresses: {
          'sched1': SchedulingAddress(
            uri: 'mailto:janedoe@example.com',
            contexts: {Context('work'): true},
            pref: 1,
            label: 'Work scheduling',
          ),
        },
        directories: {
          'dir1': Directory(
            kind: 'entry',
            uri: 'https://dir.example.com/addrbook/jdoe/Jean%20Dupont.vcf',
            pref: 1,
          ),
          'dir2': Directory(
            kind: 'directory',
            uri: 'ldap://ldap.example/o=Example%20Tech,ou=Engineering',
            pref: 2,
            listAs: 2,
          ),
        },  
        media: {
          'res45': Media(
            mediaType: 'Media',
            kind: 'sound',
            uri: 'CID:JOHNQ.part8.19960229T080000.xyzMail@example.com',
            contexts: {Context('work'): true},
            pref: 1,
            label: 'Company logo',
          ),
          'res47': Media(
            mediaType: 'Media',
            kind: 'logo',
            uri: 'https://www.example.com/pub/logos/abccorp.jpg',
            contexts: {Context('work'): true},
            pref: 2,
            label: 'profile logo',
          ),
          'res1': Media(
            mediaType: 'Media',
            kind: 'photo',
            uri: 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAASABIAAD/4...',
            contexts: {Context('work'): true},
            pref: 2,
            label: 'Company logo',
          ),
        },
        cryptoKeys: {
          'mykey1': CryptoKey(
            uri: 'https://www.example.com/keys/jdoe.cer',
            mediaType: 'application/pkix-cert',
            pref: 1,
            label: 'S/MIME certificate',
          ),
          'mykey2': CryptoKey(
            uri:
                'data:application/pgp-keys;base64,LS0tLS1CRUdJTiBSU0EgUFVC'
                'TElDIEtFWS0tLS0tCk1JSUJDZ0tDQVFFQSt4R1ovd2N6OXVnRnBQMDdOc'
                '3BvNlUxN2wwWWhGaUZweHhVNHBUazNMaWZ6OVIzenNJc3UKRVJ3dGE3K2'
                'ZXSWZ4T28yMDhldHQvamhza2lWb2RTRXQzUUJHaDRYQmlweVdvcEt3Wjk'
                'zSEhhRFZaQUFMaS8yQQoreFRCdFdkRW83WEdVdWpLRHZDMi9hWkt1a2Zq'
                'cE9pVUk4QWhMQWZqbWxjRC9VWjFRUGgwbUhzZ2xSTkNtcEN3Cm13U1hBO'
                'VZObWh6K1BpQitEbWw0V1duS1cvVkhvMnVqVFh4cTcrZWZNVTRIMmZueT'
                'NTZTNLWU9zRlBGR1oxVE4KUVNZbEZ1U2hXckhQdGlMbVVkUG9QNkNWMm1'
                'NTDF0aytsN0RJSXFYclFoTFVLREFDZU01cm9NeDBrTGhVV0I4UAorMHVq'
                'MUNObE5ONEpSWmxDN3hGZnFpTWJGUlU5WjRONll3SURBUUFCCi0tLS0tR'
                'U5EIFJTQSBQVUJMSUMgS0VZLS0tLS0K',
            mediaType: 'application/pgp-keys',
            pref: 2,
            label: 'OpenPGP public key',
          ),
        },
        anniversaries: {
          AnniversaryId('a1'): AnniversaryValue(
            type: 'PartialDate',
            kind: 'birth',
          ),
        },
        created: '2025-11-04T10:00:00Z',
        updated: '2025-11-04T12:00:00Z',
        blobId:
            'cc7y7iw2nkdd7epezg1ao0syrlmx93builderesparsedupdatesidbxa2',
      );

      // Create
      final created = await ContactUtil.createContact(
        client: httpClient,
        accountId: accountId,
        contact: contact,
        apiVersion: ContactApiVersion.ietf,
      );
      expect(created.created, isNotNull);
      final createdId = created.created!.values.first.id!.value;
      expect(createdId, isNotEmpty);

      // Get
      final fetched = await ContactUtil.getContactById(
        client: httpClient,
        accountId: accountId,
        id: createdId,
        apiVersion: ContactApiVersion.ietf,
      );
      expect(fetched, isNotNull);
      final roundtripped = fetched as ContactCard;

      expect(roundtripped.addresses, equals(contact.addresses));
      expect(roundtripped.addressBookIds, equals(contact.addressBookIds));
      expect(roundtripped.name, equals(contact.name));
      expect(roundtripped.nicknames, equals(contact.nicknames));
      expect(roundtripped.emails, equals(contact.emails));
      expect(roundtripped.phones, equals(contact.phones));
      expect(roundtripped.organizations, equals(contact.organizations));
      expect(roundtripped.titles, equals(contact.titles));
      expect(roundtripped.onlineServices, equals(contact.onlineServices));
      expect(roundtripped.preferredLanguages, equals(contact.preferredLanguages));
      expect(roundtripped.keywords, equals(contact.keywords));
      expect(roundtripped.notes, equals(contact.notes));
      expect(roundtripped.relatedTo, equals(contact.relatedTo));
      expect(roundtripped.blobId, isNotNull);
      expect(roundtripped.schedulingAddresses, equals(contact.schedulingAddresses));
      expect(roundtripped.directories, equals(contact.directories));
      expect(roundtripped.media, equals(contact.media));
      expect(roundtripped.cryptoKeys, equals(contact.cryptoKeys));
      expect(roundtripped.localizations!['jp']!.keys,
      containsAll(['addresses/k23/full', 'addresses/k23/components']));
      expect(roundtripped.anniversaries, equals(null));
      // Server currently does not set/return `anniversaries` on ContactCard,
      // so we assert that it stays null on roundtrip
      final patch = PatchObject({
        'name/components/2/value': 'Pig-Updated',
      });

      //update
      final updated = await ContactUtil.updateContact(
        client: httpClient,
        accountId: accountId,
        id: Id(createdId),
        patch: patch,
        apiVersion: ContactApiVersion.ietf,
      );

      expect(updated.notUpdated, null);

      final fetchedUpdated = await ContactUtil.getContactById(
        client: httpClient,
        accountId: accountId,
        id: createdId,
        apiVersion: ContactApiVersion.ietf,
      );

      final updatedCard = fetchedUpdated as ContactCard;

      expect(
        updatedCard.name!.components
            ?.firstWhere((c) => c.kind == 'surname')
            .value,
        equals('Pig-Updated'),
      );
 
      //delete
      final del = await ContactUtil.deleteContact(
        client: httpClient,
        accountId: accountId,
        id: Id(createdId),
        apiVersion: ContactApiVersion.ietf,
      );

      expect(del.destroyed, contains(Id(createdId)));

      final fetchedAfterDeletion = await ContactUtil.getContactById(
        client: httpClient,
        accountId: accountId,
        id: createdId,
        apiVersion: ContactApiVersion.ietf,
      );

      expect(fetchedAfterDeletion, isNull);
    });
  });
}
