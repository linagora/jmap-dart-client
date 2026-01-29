import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/address_book/address_book.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/util/address_book_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  group('AddressBook/set - mocked', () {
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

    test('create address book', () async {
      adapter.onPost(
        '',
        (server) => server.reply(
          200,
          {
            "sessionState": "s1",
            "methodResponses": [
              [
                "AddressBook/set",
                {
                  "accountId": "acc1",
                  "created": {
                    "c1": {
                      "id": "ab1",
                      "name": "Personal"
                    }
                  }
                },
                "c0"
              ]
            ]
          },
        ),
        data: Matchers.any,
      );

      final resp = await AddressBookUtil.setAddressBooks(
        client: httpClient,
        accountId: accountId,
        create: {
          Id('c1'): AddressBook(
            name: 'Personal',
          ),
        },
        methodCallId: MethodCallId('c0'),
      );

      expect(resp.accountId.id.value, 'acc1');
      expect(resp.created, isNotNull);
      expect(resp.created!.containsKey(Id('c1')), isTrue);
      expect(resp.created![Id('c1')]!.id!.value, 'ab1');
    });

    test('destroy address book', () async {
      adapter.onPost(
        '',
        (server) => server.reply(
          200,
          {
            "sessionState": "s2",
            "methodResponses": [
              [
                "AddressBook/set",
                {
                  "accountId": "acc1",
                  "destroyed": ["ab1"]
                },
                "c0"
              ]
            ]
          },
        ),
        data: Matchers.any,
      );

      final resp = await AddressBookUtil.deleteAddressBook(
        client: httpClient,
        accountId: accountId,
        id: Id('ab1'),
      );

      expect(resp.accountId.id.value, 'acc1');
      expect(resp.destroyed!.map((e) => e.value), contains('ab1'));
    });
  });

  group('AddressBook/set - IETF live', () {
    test('create address book', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );

      final uniqueName =
          'IETF Test AddressBook ${DateTime.now().millisecondsSinceEpoch}';

      final resp = await AddressBookUtil.createAddressBook(
        client: client.httpClient,
        accountId: client.accountId,
        addressBook: AddressBook(
          name: uniqueName,
        ),
      );

      expect(resp.accountId.id.value, isNotNull);
      expect(resp.created, isNotNull);
    });
  });

  group('AddressBook/set - Cyrus live', () {
    test('create address book', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_cyrus.json',
      );

      final uniqueName =
          'Cyrus Test AddressBook ${DateTime.now().millisecondsSinceEpoch}';

      final resp = await AddressBookUtil.createAddressBook(
        client: client.httpClient,
        accountId: client.accountId,
        addressBook: AddressBook(
          name: uniqueName,
        ),
      );

      expect(resp.accountId.id.value, isNotNull);
      expect(resp.created, isNotNull);
    });

    test('delete address book', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_cyrus.json',
      );

      final created = await AddressBookUtil.createAddressBook(
        client: client.httpClient,
        accountId: client.accountId,
        addressBook: AddressBook(
          name:
              'Cyrus Delete AddressBook ${DateTime.now().millisecondsSinceEpoch}',
        ),
      );

      final id = created.created!.values.first.id!;

      final resp = await AddressBookUtil.deleteAddressBook(
        client: client.httpClient,
        accountId: client.accountId,
        id: id,
      );

      expect(resp.accountId.id.value, isNotNull);
      expect(resp.destroyed!.contains(id), isTrue);
    });
  });
}
