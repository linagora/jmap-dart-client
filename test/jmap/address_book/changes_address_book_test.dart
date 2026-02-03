import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/util/address_book_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  group('AddressBook/changes - mocked', () {
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

    test('address book changes', () async {
      adapter.onPost(
        '',
        (server) => server.reply(
          200,
          {
            "sessionState": "s1",
            "methodResponses": [
              [
                "AddressBook/changes",
                {
                  "accountId": "acc1",
                  "oldState": "st1",
                  "newState": "st2",
                  "hasMoreChanges": false,
                  "created": ["ab1"],
                  "updated": ["ab2"],
                  "destroyed": ["ab3"]
                },
                "c0"
              ]
            ]
          },
        ),
        data: Matchers.any,
      );

      final resp = await AddressBookUtil.changesAddressBooks(
        client: httpClient,
        accountId: accountId,
        sinceState: State('st1'),
        methodCallId: MethodCallId('c0'),
      );

      expect(resp.accountId.id.value, 'acc1');
      expect(resp.oldState.value, 'st1');
      expect(resp.newState.value, 'st2');
      expect(resp.hasMoreChanges, isFalse);
      expect(resp.created.map((e) => e.value), contains('ab1'));
      expect(resp.updated.map((e) => e.value), contains('ab2'));
      expect(resp.destroyed.map((e) => e.value), contains('ab3'));
    });
  });

  group('AddressBook/changes - Cyrus live', () {
    test('get address book changes', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_cyrus.json',
      );

      final all = await AddressBookUtil.getAddressBooks(
        client: client.httpClient,
        accountId: client.accountId,
      );

      final initialState = all.state;

      final changes = await AddressBookUtil.changesAddressBooks(
        client: client.httpClient,
        accountId: client.accountId,
        sinceState: initialState,
      );

      expect(changes.accountId.id.value, isNotNull);
      expect(changes.oldState, isNotNull);
      expect(changes.newState, isNotNull);
      expect(changes.created, isNotNull);
      expect(changes.updated, isNotNull);
      expect(changes.destroyed, isNotNull);
    });
  });
  group('AddressBook/changes - IETF live', () {
    test('get address book changes from initial state', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );

      final getResp = await AddressBookUtil.getAddressBooks(
        client: client.httpClient,
        accountId: client.accountId,
      );

      final initialState = getResp.state;

      final changes = await AddressBookUtil.changesAddressBooks(
        client: client.httpClient,
        accountId: client.accountId,
        sinceState: initialState,
      );

      expect(changes.accountId.id.value, isNotNull);
      expect(changes.oldState.value, initialState.value);
      expect(changes.newState, isNotNull);
      expect(changes.created, isNotNull);
      expect(changes.updated, isNotNull);
      expect(changes.destroyed, isNotNull);
    });
  });
}
