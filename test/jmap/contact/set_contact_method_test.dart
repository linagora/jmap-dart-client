import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/contact/address_values.dart';
import 'package:jmap_dart_client/jmap/contact/anniversary_values.dart';
import 'package:jmap_dart_client/jmap/contact/card.dart';
import 'package:jmap_dart_client/jmap/contact/contact_ids.dart';
import 'package:jmap_dart_client/jmap/contact/components.dart';
import 'package:jmap_dart_client/jmap/contact/contact_card.dart';
import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/contact/context.dart';
import 'package:jmap_dart_client/jmap/contact/email_values.dart';
import 'package:jmap_dart_client/jmap/contact/language_preference.dart';
import 'package:jmap_dart_client/jmap/contact/name.dart';
import 'package:jmap_dart_client/jmap/contact/nicknames.dart';
import 'package:jmap_dart_client/jmap/contact/online_service_values.dart';
import 'package:jmap_dart_client/jmap/contact/organization_unit.dart';
import 'package:jmap_dart_client/jmap/contact/organization_values.dart';
import 'package:jmap_dart_client/jmap/contact/phone_values.dart';
import 'package:jmap_dart_client/jmap/contact/pronouns.dart';
import 'package:jmap_dart_client/jmap/contact/related_to_relation.dart';
import 'package:jmap_dart_client/jmap/contact/related_to_values.dart';
import 'package:jmap_dart_client/jmap/contact/speak_to_as.dart';
import 'package:jmap_dart_client/jmap/contact/street.dart';
import 'package:jmap_dart_client/jmap/contact/title_values.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/util/contact_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  group('Card/set JSContact - Live API', () {
    test('Card create -> get -> update -> get -> delete contact [JSContact]', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_jscontact.json',
      );

      final contact = Card(
        fullName: 'looktest',
        prodId: '12332',
        nickNames: ['test 21'],
        created: '13-4-2023',
        kind: 'testing',
        name: Name(
          components: {
            Components(kind: 'given', value: 'Pepa'),
            Components(kind: 'surname', value: 'Piglet'),
          },
        ),
        organizations: {
          OrganizationName('a49d'):
              OrganizationValue(type: 'organize', name: 'test',  units: [OrganizationUnit(name: '123')],)
        },
        phones: {
          PhoneId('a49d'): PhoneValue(
            number: '123',
            contexts: {Context('mobile'): true},
          )
        },
        anniversaries: {
          AnniversaryId('123'): const AnniversaryValue(
            type: 'organize',
            anniversaryType: 'test',
            date: '12-04-2023',
          )
        },
        relatedTo: {
          RelatedToName('Frankie'): RelatedToValue(
            type: 'Relation',
            relation: {Relation('spouse'): true},
          )
        },
        speakToAs: SpeakToAs.speakToAs(
        grammaticalGender: 'male',
        pronouns: {
          'k1': Pronouns.pronouns(
            pronouns: 'he/him',
            pref: 1,
          ),
        },
      ),
        emails: {
          EmailId('123'): EmailValue(
            type: 'organize',
            email: 'test@gmail.com',
            label: '12-04-2023',
            pref: 1,
            contexts: {Context('work'): true},
          ),
        },
        addresses: {
          AddressId('345'): AddressValue(
            type: 'Address',
            contexts: {Context('work'): true},
            street: {
              Street(
                typeName: 'StreetComponent',
                type: 'name',
                value: 'dudweiler',
              )
            },
          )
        },
        titles: {
          TitleId('455'):
              TitleValue(type: 'Title', title: 'assistent Manager', organization: null)
        },
      );

      final created = await ContactUtil.createContact(
        client: client.httpClient,
        accountId: client.accountId,
        contact: contact,
        apiVersion: ContactApiVersion.jscontact,
      );
      expect(created.created, isNotNull);

      final createdId = created.created!.values.first.id!;

      final getResponse = await ContactUtil.getContactById(
        client: client.httpClient,
        accountId: client.accountId,
        id: createdId.value,
        apiVersion: ContactApiVersion.jscontact,
      );

      final fetched = getResponse! as Card;

      expect(fetched.fullName, equals('looktest'));
      expect(fetched.kind, equals('testing'));
      expect(fetched.nickNames, contains('test 21'));

      await ContactUtil.updateContact(
        client: client.httpClient,
        accountId: client.accountId,
        id: createdId,
        patch: PatchObject({'fullName': 'updated name'}),
        apiVersion: ContactApiVersion.jscontact,
      );

      final deleted = await ContactUtil.deleteContact(
        client: client.httpClient,
        accountId: client.accountId,
        id: createdId,
        apiVersion: ContactApiVersion.jscontact,
      );

      expect(deleted.destroyed, contains(createdId));
    }, timeout: const Timeout(Duration(seconds: 600)));
  });
  group('ContactCard/set IETF - Live API', () {
    test('ContactCard create -> get -> update -> get -> delete -> get (notFound) [IETF]', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );
      
      // Create ContactCard
      final created = await ContactUtil.createContact(
        client: client.httpClient,
        accountId: client.accountId,
        contact: ContactCard(
          addressBookIds: {'b': true},
          nicknames: {
            '123': Nickname(name: 'Peppy'),
          },
          name: Name(
            components: {
              Components(kind: 'given', value: 'Pepa'),
              Components(kind: 'surname', value: 'Pig'),
              Components(kind: 'surname2', value: 'Heavens'),
            },
            isOrdered: true,
          ),
          emails: {
            EmailId('1'): EmailValue(
              email: 'pepa@example.org',
              contexts: {Context('work'): true},
              label: 'Work',
            ),
            EmailId('2'): EmailValue(
              email: 'piggy@family.org',
              contexts: {Context('private'): true},
            ),
          },
          phones: {
            PhoneId('1'): PhoneValue(
              type: 'mobile',
              phone: '+4912345678',
              number: '1111',
              contexts: {Context('private'): true},
            ),
            PhoneId('2'): PhoneValue(
              type: 'home',
              phone: '+4968123456',
              number: '1111',
              contexts: {Context('work'): true},
            ),
          },
          addresses: {
            AddressId('1'): AddressValue(
              type: 'home',
              street: {Street(value: 'Main Street 2')},
              locality: 'home',
              region: 'SL',
              postcode: '66126',
              country: 'Germany',
              coordinates: '5.12,9.121',
            ),
            AddressId('2'): AddressValue(
              type: 'work',
              street: {Street(value: 'Office Park 10')},
              locality: 'work',
              postcode: '10117',
              country: 'Germany',
              coordinates: '1.234,5.6789',
            ),
          },
          organizations: {
            OrganizationName('org1'):
                OrganizationValue(name: 'Pig Enterprises GmbH'),
          },
          titles: {
            TitleId('le9'): TitleValue(
              kind: 'title',
              name: 'Research Scientist',
            ),
            TitleId('k2'): TitleValue(
              kind: 'role',
              name: 'Project Leader',
              organizationId: 'o2',
            ),
          },
          onlineServices: {
            'os1': OnlineServiceValue(
              service: 'Twitter',
              uri: 'https://twitter.com/pepapig',
            ),
            'os2': OnlineServiceValue(
              service: 'LinkedIn',
              uri: 'https://linkedin.com/in/pepapig',
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
            ),
          },
          created: '2025-11-04T10:00:00Z',
          updated: '2025-11-04T12:00:00Z',
          blobId:
              'cc7y7iw2nkdd7epezg1ao0syrlmx93builderesparsedUpdatesidbxa39ilcreateMethod2pklyqxwbuilderesparsedDelete33333q1das',
        ),
        apiVersion: ContactApiVersion.ietf,
      );

      expect(created.created, isNotNull);
      final id = created.created!.values.first.id!;
      expect(id.value, isNotEmpty);

      // Fetch after create
      final fetchedAfterCreate = await ContactUtil.getContactById(
        client: client.httpClient,
        accountId: client.accountId,
        id: id.value,
        apiVersion: ContactApiVersion.ietf,
      );
      expect(fetchedAfterCreate, isNotNull);
      final createdCard = fetchedAfterCreate as ContactCard;

      expect(createdCard.addressBookIds, equals({'b': true}));
      expect(
        createdCard.name!.components
            ?.firstWhere((c) => c.kind == 'surname')
            .value,
        equals('Pig'),
      );
      expect(
        createdCard.emails!.values.map((e) => e.email).toSet(),
        containsAll({'pepa@example.org', 'piggy@family.org'}),
      );

      final patch = PatchObject({
        'name/components/1/value': 'Pig-Updated',
      });

      // Update contact
      final update = await ContactUtil.updateContact(
        client: client.httpClient,
        accountId: client.accountId,
        id: id,
        patch: patch,
        apiVersion: ContactApiVersion.ietf,
      );

      expect(update.updated, isNotNull);
      expect(update.notUpdated == null || !update.notUpdated!.containsKey(id),
          isTrue);
      
      // Fetch after update
      final fetchedAfterUpdate = await ContactUtil.getContactById(
        client: client.httpClient,
        accountId: client.accountId,
        id: id.value,
        apiVersion: ContactApiVersion.ietf,
      );
      expect(fetchedAfterUpdate, isNotNull);
      final updatedCard = fetchedAfterUpdate as ContactCard;

      expect(
        updatedCard.name!.components
            ?.firstWhere((c) => c.kind == 'surname')
            .value,
        equals('Pig-Updated'),
      );
      
      // Delete contact
      final del = await ContactUtil.deleteContact(
        client: client.httpClient,
        accountId: client.accountId,
        id: id,
        apiVersion: ContactApiVersion.ietf,
      );
      expect(del.destroyed, contains(id));

      // Fetch after delete
      final getAfterDelete = await ContactUtil.getContactById(
        client: client.httpClient,
        accountId: client.accountId,
        id: id.value,
        apiVersion: ContactApiVersion.ietf,
      );

      expect(getAfterDelete, isNull);
    });
  });

  group('Card/set Cyrus - Live API', () {
    test('Card create -> get -> update -> get -> delete -> get (notFound) [Cyrus]', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_cyrus.json',
      );

      final created = await ContactUtil.createContact(
        client: client.httpClient,
        accountId: client.accountId,
        contact: Card(
          created: '22-10-2025',
          fullName: 'test address',
          organizations: {
            OrganizationName('org1'): OrganizationValue(
              name: 'audriga GmbH',
            ),
          },
          anniversaries: {
            AnniversaryId('a1'): const AnniversaryValue(
              // TODO: If not a PartialDate, Anniversary.date should be a TimeStamp.
              //  Compare https://www.rfc-editor.org/rfc/rfc9553.html#name-anniversaries
              date: '2023-05-10',
            ),
          },
          emails: {
            EmailId('1'): EmailValue(
              type: 'work',
              email: 'another@example.org',
            ),
          },
          phones: {
            PhoneId('1'): PhoneValue(
              type: 'mobile',
              phone: '+4912345678',
            ),
          },
          addresses: {
            AddressId('a1'): AddressValue(
              type: 'home',
              street: {Street(value: 'Main Street 5')},
              locality: 'Karlsruhe',
              region: 'BW',
              postcode: '76133',
              country: 'Germany',
            ),
          },
        ),
        apiVersion: ContactApiVersion.cyrus,
      );

      expect(created.created, isNotNull);

      final id = created.created!.values.first.id!;

      // Verify created state via fetch
      final initialFetch = await ContactUtil.getContacts(
        client: client.httpClient,
        accountId: client.accountId,
        apiVersion: ContactApiVersion.cyrus,
      );

      final createdContact = initialFetch.list.firstWhere(
        (c) => c.id?.value == id.value,
        orElse: () => throw StateError('Created contact not found'),
      ) as Card;

      expect(createdContact.addresses![AddressId('addr0')]!.street!.first.value, equals('Main Street 5'));
      expect(createdContact.fullName, equals('test address'));
      expect(
        createdContact.organizations![OrganizationName('org1')]!.name,
        equals('audriga GmbH'),
      );
      expect(
        createdContact.anniversaries![AnniversaryId('a1')]!.date,
        equals('2023-05-10'),
      );
      expect(
        createdContact.phones![PhoneId('phone0')]!.phone,
        equals('+4912345678'),
      );
      // Update
      await ContactUtil.updateContact(
        client: client.httpClient,
        accountId: client.accountId,
        id: id,
        patch: PatchObject({
          'firstName': 'Updated User',
          'lastName': 'Test User',
          'emails': [
            {'type': 'work', 'value': 'updated@example.org'}
          ],
          'phones': [
            {'type': 'mobile', 'value': '+4922222222'}
          ],
        }),
        apiVersion: ContactApiVersion.cyrus,
      );

      // Fetch again and verify updated fields
      final fetched = await ContactUtil.getContacts(
        client: client.httpClient,
        accountId: client.accountId,
        apiVersion: ContactApiVersion.cyrus,
      );

      final updatedContact = fetched.list.firstWhere(
        (c) => c.id?.value == id.value,
        orElse: () => throw StateError('Updated contact not found'),
      ) as Card;

      expect(updatedContact.blobId, isNotNull);
      expect(updatedContact.id?.value, id.value);
      final updatedEmail = updatedContact.emails!.values.first;
      expect(updatedEmail.email, equals('updated@example.org'));

      final updatedPhone = updatedContact.phones!.values.first;
      expect(updatedPhone.phone, equals('+4922222222'));

      // Delete contact
      final del = await ContactUtil.deleteContact(
        client: client.httpClient,
        accountId: client.accountId,
        id: id,
        apiVersion: ContactApiVersion.cyrus,
      );
      expect(del.destroyed, contains(id));

      // Fetch after delete
      final getAfterDelete = await ContactUtil.getContactById(
        client: client.httpClient,
        accountId: client.accountId,
        id: id.value,
        apiVersion: ContactApiVersion.cyrus,
      );

      expect(getAfterDelete, isNull);
    });
  });

  group('contact/set - Mock', () {
    late Dio dio;
    late DioAdapter mock;
    late HttpClient http;

    const base = 'https://mocked.test/jmap';
    final acc = AccountId(Id('acc1'));

    setUp(() {
      dio = Dio(BaseOptions(method: 'POST', baseUrl: base));
      mock = DioAdapter(dio: dio);
      http = HttpClient(dio);
    });

    test('Card create update delete 1', () async {
      mock.onPost(
        '',
        (server) {
          server.reply(200, {
            "sessionState": "s1",
            "methodResponses": [
              [
                "Card/set",
                {
                  "accountId": "acc1",
                  "created": {
                    "c1": {"id": "c1#new.vcf", "fullName": "Look Test"}
                  }
                },
                "c0"
              ]
            ]
          });
        },
        data: Matchers.any,
      );

      final r1 = await ContactUtil.setContacts(
        client: http,
        accountId: acc,
        create: {Id('c1'): Card(fullName: 'Look Test')},
        apiVersion: ContactApiVersion.jscontact,
      );

      expect(r1.created![Id('c1')]!, isNotNull);

      mock.onPost(
        '',
        (server) {
          server.reply(200, {
            "sessionState": "s2",
            "methodResponses": [
              [
                "Card/set",
                {
                  "accountId": "acc1",
                  "updated": {
                    "c1": {"id": "c1#updated.vcf", "fullName": "Updated Look"}
                  }
                },
                "c0"
              ]
            ]
          });
        },
        data: Matchers.any,
      );

      final r2 = await ContactUtil.updateContact(
        client: http,
        accountId: acc,
        id: Id('c1'),
        patch: PatchObject({"fullName": "Updated Look"}),
        apiVersion: ContactApiVersion.jscontact,
      );

      expect(r2.updated![Id('c1')]!, isNotNull);

      mock.onPost(
        '',
        (server) {
          server.reply(200, {
            "sessionState": "s3",
            "methodResponses": [
              [
                "Card/set",
                {
                  "accountId": "acc1",
                  "destroyed": ["c1"]
                },
                "c0"
              ]
            ]
          });
        },
        data: Matchers.any,
      );

      final r3 = await ContactUtil.deleteContact(
        client: http,
        accountId: acc,
        id: Id('c1'),
        apiVersion: ContactApiVersion.jscontact,
      );

      expect(r3.destroyed, contains(Id('c1')));
    });

    test('Card create update delete 2', () async {
      mock.onPost(
        '',
        (server) {
          server.reply(
            200,
            {
              'sessionState': 's1',
              'methodResponses': [
                [
                  'Contact/set',
                  {
                    'accountId': 'acc1',
                    'created': {
                      'c1': {
                        'id': 'contact1',
                        'firstName': 'Alice',
                        'lastName': 'Brown'
                      }
                    }
                  },
                  'c0'
                ]
              ]
            },
          );
        },
        data: Matchers.any,
      );

      final created = await ContactUtil.setContacts(
        client: http,
        accountId: acc,
        create: {Id('c1'): Card(fullName: 'Alice Brown')},
        apiVersion: ContactApiVersion.cyrus,
      );

      expect(created.created, isNotEmpty);

      mock.onPost(
        '',
        (server) {
          server.reply(
            200,
            {
              'sessionState': 's2',
              'methodResponses': [
                [
                  'Contact/set',
                  {
                    'accountId': 'acc1',
                    'updated': {
                      'contact1': {
                        'id': 'contact1',
                        'firstName': 'Alice',
                        'lastName': 'Updated'
                      }
                    }
                  },
                  'c0'
                ]
              ]
            },
          );
        },
        data: Matchers.any,
      );

      final upd = await ContactUtil.updateContact(
        client: http,
        accountId: acc,
        id: Id('contact1'),
        patch: PatchObject({
          'lastName': 'Updated',
          'emails': [
            {'type': 'work', 'value': 'alice.updated@example.org'}
          ]
        }),
        apiVersion: ContactApiVersion.cyrus,
      );

      expect(upd.updated, isNotEmpty);

      mock.onPost(
        '',
        (server) {
          server.reply(
            200,
            {
              'sessionState': 's3',
              'methodResponses': [
                [
                  'Contact/set',
                  {
                    'accountId': 'acc1',
                    'destroyed': ['contact1']
                  },
                  'c0'
                ]
              ]
            },
          );
        },
        data: Matchers.any,
      );

      final del = await ContactUtil.deleteContact(
        client: http,
        accountId: acc,
        id: Id('contact1'),
        apiVersion: ContactApiVersion.cyrus,
      );

      expect(del.destroyed, contains(Id('contact1')));
    });

    test('ContactCard create update delete', () async {
      mock.onPost(
        '',
        (s) {
          s.reply(200, {
            'sessionState': 's1',
            'methodResponses': [
              [
                'ContactCard/set',
                {
                  'accountId': 'accIetf',
                  'created': {
                    'c1': {
                      'id': 'ietf-contact-1',
                      'addressBookIds': {'b': true}
                    }
                  }
                },
                'c0'
              ]
            ]
          });
        },
        data: Matchers.any,
      );

      await ContactUtil.setContacts(
        client: http,
        accountId: acc,
        create: {Id('c1'): ContactCard(addressBookIds: {'b': true})},
        apiVersion: ContactApiVersion.ietf,
      );

      mock.onPost(
        '',
        (s) {
          s.reply(200, {
            'sessionState': 's2',
            'methodResponses': [
              [
                'ContactCard/set',
                {
                  'accountId': 'accIetf',
                  'updated': {
                    'ietf-contact-1': {
                      'id': 'ietf-contact-1',
                      'addressBookIds': {'b': true}
                    }
                  }
                },
                'c0'
              ]
            ]
          });
        },
        data: Matchers.any,
      );

      await ContactUtil.updateContact(
        client: http,
        accountId: acc,
        id: Id('ietf-contact-1'),
        patch: PatchObject({'addressBookIds': {'b': true}}),
        apiVersion: ContactApiVersion.ietf,
      );

      mock.onPost(
        '',
        (s) {
          s.reply(200, {
            'sessionState': 's3',
            'methodResponses': [
              [
                'ContactCard/set',
                {
                  'accountId': 'accIetf',
                  'destroyed': ['ietf-contact-1']
                },
                'c0'
              ]
            ]
          });
        },
        data: Matchers.any,
      );

      final del = await ContactUtil.deleteContact(
        client: http,
        accountId: acc,
        id: Id('ietf-contact-1'),
        apiVersion: ContactApiVersion.ietf,
      );

      expect(del.destroyed, contains(Id('ietf-contact-1')));
    });
  });
}
