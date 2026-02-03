import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/util/address_book_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  group('AddressBook/get - mocked', () {
    late Dio dio;
    late DioAdapter adapter;
    late HttpClient httpClient;
    final accountId = AccountId(Id('acc1'));

    setUp(() {
      dio = Dio(BaseOptions(method: 'POST'))
        ..options.baseUrl = 'https://mocked.example/jmap';
      adapter = DioAdapter(dio: dio);
      httpClient = HttpClient(dio);
    });

    test('get address books', () async {
      adapter.onPost(
        '',
        (server) => server.reply(
          200,
          {
            "sessionState": "s1",
            "methodResponses": [
              [
                "AddressBook/get",
                {
                  "accountId": "acc1",
                  "state": "st1",
                  "list": [
                    {
                      "id": "ab1",
                      "name": "Personal",
                      "isVisible": true
                    },
                    {
                      "id": "ab2",
                      "name": "Work",
                      "isVisible": false
                    }
                  ]
                },
                "c0"
              ]
            ]
          },
        ),
        data: Matchers.any,
      );

      final resp = await AddressBookUtil.getAddressBooks(
        client: httpClient,
        accountId: accountId,
      );

      expect(resp.accountId.id.value, 'acc1');
      expect(resp.list.length, 2);
      expect(resp.list.first.name, 'Personal');
    });

    test('get address book by id', () async {
      adapter.onPost(
        '',
        (server) => server.reply(
          200,
          {
            "sessionState": "s2",
            "methodResponses": [
              [
                "AddressBook/get",
                {
                  "accountId": "acc1",
                  "state": "st2",
                  "list": [
                    {
                      "id": "ab1",
                      "name": "Personal",
                      "isVisible": true
                    }
                  ]
                },
                "c0"
              ]
            ]
          },
        ),
        data: Matchers.any,
      );

      final ab = await AddressBookUtil.getAddressBookById(
        client: httpClient,
        accountId: accountId,
        id: 'ab1',
      );

      expect(ab, isNotNull);
      expect(ab!.id!.value, 'ab1');
      expect(ab.name, 'Personal');
    });
  });

  group('AddressBook/get - IETF live', () {
    test('get address books', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );

      final resp = await AddressBookUtil.getAddressBooks(
        client: client.httpClient,
        accountId: client.accountId,
      );

      expect(resp.accountId.id.value, isNotNull);
      expect(resp.list, isNotEmpty);
    });

    test('get single address book by id', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );

      final all = await AddressBookUtil.getAddressBooks(
        client: client.httpClient,
        accountId: client.accountId,
      );

      final first = all.list.first;

      final fetched = await AddressBookUtil.getAddressBookById(
        client: client.httpClient,
        accountId: client.accountId,
        id: first.id!.value,
      );

      expect(fetched, isNotNull);
      expect(fetched!.id!.value, first.id!.value);
    });
  });

  group('AddressBook/get - Cyrus live', () {
    test('get address books', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_cyrus.json',
      );

      final resp = await AddressBookUtil.getAddressBooks(
        client: client.httpClient,
        accountId: client.accountId,
      );

      expect(resp.accountId.id.value, isNotNull);
      expect(resp.list, isNotEmpty);
    });

    test('get single address book by id', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_cyrus.json',
      );

      final all = await AddressBookUtil.getAddressBooks(
        client: client.httpClient,
        accountId: client.accountId,
      );

      final first = all.list.first;

      final fetched = await AddressBookUtil.getAddressBookById(
        client: client.httpClient,
        accountId: client.accountId,
        id: first.id!.value,
      );

      expect(fetched, isNotNull);
      expect(fetched!.id!.value, first.id!.value);
    });
  });
}
