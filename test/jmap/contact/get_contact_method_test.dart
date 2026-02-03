import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/contact/card.dart';
import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/contact/contact_card.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/util/contact_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  late HttpClient httpClient;
  late AccountId accountId;

  group('jscontact Contact API - Live Test', () {
    setUp(() async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_jscontact.json',
      );
      httpClient = client.httpClient;
      accountId = client.accountId;
    });

    test('get card method and response parsing', () async {
      final resultList = await ContactUtil.getContacts(
        client: httpClient,
        accountId: accountId,
        apiVersion: ContactApiVersion.jscontact,
      );

      expect(resultList, isNotNull);
      expect(resultList.accountId.id.value, accountId.id.value);
      expect(resultList.list.length, greaterThanOrEqualTo(1));

      for (final contact in resultList.list) {
        final card = contact as Card;
        expect(card.id, isNotNull);
        expect(card.id!.value, isNotEmpty);
        expect(card.type, isNotNull);
        expect(card.fullName!.trim().isNotEmpty, true);                              }
    });

    test('get single card by id', () async {
      final all = await ContactUtil.getContacts(
        client: httpClient,
        accountId: accountId,
        apiVersion: ContactApiVersion.jscontact,
      );

      expect(all.list.isNotEmpty, true);

      final first = all.list.first;
      final id = first.id?.value;

      final fetched = await ContactUtil.getContactById(
        client: httpClient,
        accountId: accountId,
        id: id!,
        apiVersion: ContactApiVersion.jscontact,
      );
      final card = fetched;
      expect(card, isNotNull);
      expect(card!.id?.value, id);
    }, timeout: const Timeout(Duration(seconds: 300)));
  });

  group('Cyrus Contact API - Live Test', () {
    setUp(() async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_cyrus.json',
      );
      httpClient = client.httpClient;
      accountId = client.accountId;
    });

    test('get cyrus contact', () async {

      final response = await ContactUtil.getContacts(
        client: httpClient,
        accountId: accountId,
        apiVersion: ContactApiVersion.cyrus,
      );
      expect(response, isNotNull);
      expect(response.state, isNotNull);
      expect(response.list, isNotEmpty);

      final card = response.list.first as Card;
      expect(card.fullName, isNotNull);
     });
  });

  group('IETF Contact API - Live Test', () {
    test('get ContactCard', () async {
      final env = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );

      final http = env.httpClient;
      final accId = env.accountId;

      await ContactUtil.createContact(
        client: http,
        accountId: accId,
        contact: ContactCard(addressBookIds: {'b': true}),
        apiVersion: ContactApiVersion.ietf,
      );

      final parsed = await ContactUtil.getContacts(
        client: http,
        accountId: accId,
        apiVersion: ContactApiVersion.ietf,
      );

      expect(parsed.list, isNotNull);
      expect(parsed.list.length, greaterThanOrEqualTo(1));
    });
  }); 

  group('Contact/get - mocked', () {
    late Dio dio;
    late DioAdapter mock;
    late HttpClient http;

    const base = 'https://mocked.test/jmap';
    final accId = AccountId(Id('acc1'));

    setUp(() {
      dio = Dio(BaseOptions(method: 'POST', baseUrl: base));
      mock = DioAdapter(dio: dio);
      http = HttpClient(dio);
    });

      test('Card/get returns list', () async {
      mock.onPost(
        '',
        (s) => s.reply(200, {
          "sessionState": "s1",
          "methodResponses": [
            [
              "Card/get",
              {
                "accountId": "acc1",
                "state": "st-1",
                "list": [
                  {
                    "id": "c1#john.vcf",
                    "@type": "Card",
                    "fullName": "John Doe",
                    "emails": {"e1": {"email": "john@example.com"}}
                  },
                  {
                    "id": "c2#jane.vcf",
                    "@type": "Card",
                    "fullName": "Jane Smith",
                    "phones": {"p1": {"phone": "+1-555-0101"}}
                  }
                ],
                "notFound": []
              },
              "c0"
            ]
          ]
        }),
        data: {
          "using": [
            "urn:ietf:params:jmap:core",
            "https://www.audriga.eu/jmap/jscontact/"
          ],
          "methodCalls": [
            ["Card/get", {"accountId": "acc1"}, "c0"]
          ]
        },
      );

      final parsed = await ContactUtil.getContacts(
        client: http,
        accountId: accId,
        apiVersion: ContactApiVersion.jscontact,
      );

      expect(parsed.accountId.id.value, 'acc1');
      expect(parsed.state.value, 'st-1');
      expect(parsed.list.length, 2);

      final card1 = parsed.list[0] as Card;
      final card2 = parsed.list[1] as Card;

      expect(card1.fullName, 'John Doe');
      expect(card2.fullName, 'Jane Smith');

      expect(parsed.notFound, isEmpty);
    });

    test('Contact/get returns list of contacts', () async {
     mock.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "s3",
          "methodResponses": [
            [
              "Contact/get",
              {
                "accountId": "acc1",
                "state": "st-1",
                "list": [
                  {
                    "id": "contact1",
                    "@type": "Contact",
                    "fullName": "Alice Brown",
                    "emails": [
                      {"email": "alice@example.org"}
                    ]
                  },
                  {
                    "id": "contact2",
                    "@type": "Contact",
                    "fullName": "Bob Johnson",
                    "phones": [
                      {"phone": "+49-1234-5678"}
                    ]
                  }
                ],
                "notFound": []
              },
              "c0"
            ]
          ]
        }),
        data: {
          "using": [
            "urn:ietf:params:jmap:core",
            "https://cyrusimap.org/ns/jmap/contacts"
          ],
          "methodCalls": [
            ["Contact/get", {"accountId": "acc1"}, "c0"]
          ]
        },
      );

      final parsed = await ContactUtil.getContacts(
        client: http,
        accountId: accId,
        apiVersion: ContactApiVersion.cyrus,
      );

      expect(parsed.list.length, 2);
      final card1 = parsed.list[0] as Card;
      final card2 = parsed.list[1] as Card;

      expect(card2.fullName, 'Bob Johnson');
      expect(card1.fullName, 'Alice Brown');
      expect(parsed.notFound, isEmpty);
    });

    test('ContactCard/get returns list of contacts', () async {
      mock.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "s4",
          "methodResponses": [
            [
              "ContactCard/get",
              {
                "accountId": "acc1",
                "state": "st-1",
                "list": [
                  {
                    "id": "ietf-contact-1",
                    "@type": "ContactCard",
                    "emails": {
                      "e1": {"email": "charlie@ietf.org"}
                    }
                  },
                  {
                    "id": "ietf-contact-2",
                    "@type": "ContactCard",
                    "phones": {
                      "p1": {"phone": "+44-20-1234-5678"}
                    }
                  }
                ],
                "notFound": []
              },
              "c0"
            ]
          ]
        }),
        data: {
          "using": [
            "urn:ietf:params:jmap:core",
            "urn:ietf:params:jmap:contacts"
          ],
          "methodCalls": [
            ["ContactCard/get", {"accountId": "acc1"}, "c0"]
          ]
        },
      );

      final parsed = await ContactUtil.getContacts(
        client: http,
        accountId: accId,
        apiVersion: ContactApiVersion.ietf,
      );

      expect(parsed.list.length, 2);
      expect(parsed.list[0].id!.value, 'ietf-contact-1');
      expect(parsed.list[1].id!.value, 'ietf-contact-2');
      expect(parsed.notFound, isEmpty);
    });
  });
}
