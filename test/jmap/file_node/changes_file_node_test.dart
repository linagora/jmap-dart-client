import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/util/file_node_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  group('IETF FileNode - Live Test', () {
    test('FileNode/changes live (using utils only)', () async {
      final liveClient = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );
      final httpClient = liveClient.httpClient;
      final accountId = liveClient.accountId;

      final initialResp = await FileNodeUtil.getFileNodes(
        client: httpClient,
        accountId: accountId,
      );

      final initialState = initialResp.state;
      expect(initialState.value, isNotEmpty);

      final changes = await FileNodeUtil.changesFileNodes(
        client: httpClient,
        accountId: accountId,
        sinceState: initialState,
      );

      expect(changes.accountId.id.value, accountId.id.value);
      expect(changes.oldState.value, initialState.value);
      expect(changes.newState.value, isNotEmpty);
    });
  });

  group('FileNode/changes - Mock Tests', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late HttpClient httpClient;

    const apiBase = 'https://mocked.test/jmap';
    final accountId = AccountId(Id('accFile'));

    setUp(() {
      dio = Dio(BaseOptions(method: 'POST', baseUrl: apiBase));
      dioAdapter = DioAdapter(dio: dio);
      httpClient = HttpClient(dio);
    });

    test('FileNode/changes - mocked', () async {
      dioAdapter.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "s-chg",
          "methodResponses": [
            [
              "FileNode/changes",
              {
                "accountId": "accFile",
                "oldState": "st-0",
                "newState": "st-1",
                "hasMoreChanges": false,
                "created": ["fNew"],
                "updated": ["f1"],
                "destroyed": ["fOld"]
              },
              "c0"
            ]
          ]
        }),
        data: {
          "methodCalls": [
            [
              "FileNode/changes",
              {
                "accountId": "accFile",
                "sinceState": "st-0"
              },
              "c0"
            ]
          ],
          "using": [
            "urn:ietf:params:jmap:core",
            "urn:ietf:params:jmap:filenode"
          ]
        },
      );

      final parsed = await FileNodeUtil.changesFileNodes(
        client: httpClient,
        accountId: accountId,
        sinceState: State("st-0"),
      );

      expect(parsed.accountId.id.value, 'accFile');
      expect(parsed.oldState.value, 'st-0');
      expect(parsed.newState.value, 'st-1');
      expect(parsed.created.first.value, 'fNew');
      expect(parsed.updated.first.value, 'f1');
      expect(parsed.destroyed.first.value, 'fOld');
    });
  });
}
