import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/contact/contact_api_version.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/util/contact_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  group('IETF ContactCard/changes - live', () {
    test('fetches changes from live IETF server', () async {
      final liveClient = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );

      final getResp = await ContactUtil.getContacts(
        client: liveClient.httpClient,
        accountId: liveClient.accountId,
        apiVersion: ContactApiVersion.ietf,
      );

      final changes = await ContactUtil.changesContacts(
        client: liveClient.httpClient,
        accountId: liveClient.accountId,
        sinceState: getResp.state,
        apiVersion: ContactApiVersion.ietf,
      );

      expect(changes.oldState.value, isNotNull);
      expect(changes.newState.value, isNotNull);
    });
  });


  group('Cyrus Contact/changes - live', () {
    test('fetches changes from live Cyrus server', () async {
      final liveClient = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_cyrus.json',
      );

      final getResp = await ContactUtil.getContacts(
        client: liveClient.httpClient,
        accountId: liveClient.accountId,
        apiVersion: ContactApiVersion.cyrus,
      );

      final changes = await ContactUtil.changesContacts(
        client: liveClient.httpClient,
        accountId: liveClient.accountId,
        sinceState: getResp.state,
        apiVersion: ContactApiVersion.cyrus,
      );

      expect(changes.oldState.value, isNotNull);
      expect(changes.newState.value, isNotNull);
    });
  });

  group('Contact/changes - mocked', () {
    late Dio dio;
    late DioAdapter mock;
    late HttpClient http;

    const base = 'https://mocked.test/jmap';
    final acc = AccountId(Id('accCyrus'));

    setUp(() {
      dio = Dio(BaseOptions(method: 'POST', baseUrl: base));
      mock = DioAdapter(dio: dio);
      http = HttpClient(dio);
    });

    test('Contact/changes returns created, updated, destroyed', () async {
      mock.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "s5",
          "methodResponses": [
            [
              "Contact/changes",
              {
                "accountId": "accCyrus",
                "oldState": "st-10",
                "newState": "st-11",
                "hasMoreChanges": false,
                "created": ["c1"],
                "updated": ["c2"],
                "destroyed": ["c3"]
              },
              "c0"
            ]
          ]
        }),
        data: Matchers.any,
      );

      final resp = await ContactUtil.changesContacts(
        client: http,
        accountId: acc,
        sinceState: State("st-10"),
        apiVersion: ContactApiVersion.cyrus,
      );

      expect(resp.oldState.value, "st-10");
      expect(resp.newState.value, "st-11");
      expect(resp.created.first.value, "c1");
      expect(resp.updated.first.value, "c2");
      expect(resp.destroyed.first.value, "c3");
    });
    test('ContactCard/changes returns created, updated, destroyed', () async {
      mock.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "s6",
          "methodResponses": [
            [
              "ContactCard/changes",
              {
                "accountId": "accIetf",
                "oldState": "st-20",
                "newState": "st-21",
                "hasMoreChanges": true,
                "created": ["i1"],
                "updated": ["i2"],
                "destroyed": []
              },
              "c0"
            ]
          ]
        }),
        data: Matchers.any,
      );

      final resp = await ContactUtil.changesContacts(
        client: http,
        accountId: acc,
        sinceState: State("st-20"),
        apiVersion: ContactApiVersion.ietf,
      );

      expect(resp.oldState.value, "st-20");
      expect(resp.newState.value, "st-21");
      expect(resp.created.first.value, "i1");
      expect(resp.updated.first.value, "i2");
      expect(resp.destroyed, isEmpty);
      expect(resp.hasMoreChanges, true);
    });
  });
}
