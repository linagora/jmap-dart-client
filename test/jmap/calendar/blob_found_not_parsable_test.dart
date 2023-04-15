import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';

void main() {
  group('blob found not parsable test', () {
    {
      final requesttoparse = {
        "using": [
          "urn:ietf:params:jmap:core",
          "com:linagora:params:calendar:event"
        ],
        "methodCalls": [
          [
            "CalendarEvent/parse",
            {
              "accountId":
                  "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
              "blobIds": ["037aaad3-17c9-47c8-bd6b-f2cbfe925ef7"]
            },
            "c1"
          ]
        ]
      };

      final response1 = {
        "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
        "methodResponses": [
          [
            "CalendarEvent/parse",
            {
              "accountId":
                  "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
              "notParsable": ["037aaad3-17c9-47c8-bd6b-f2cbfe925ef7"]
            },
            "c1"
          ]
        ]
      };

      test('blob found not parsable', () async {
        final baseOption = BaseOptions(method: 'POST');
        final dio = Dio(baseOption)
          ..options.baseUrl =
              "https://gateway.upn.integration-open-paas.org"; //'http://domain.com/jmap';
        final dioAdapter = DioAdapter(dio: dio);
        dioAdapter.onPost('', (server) => server.reply(200, response1),
            data: requesttoparse,
            headers: {
              "accept": "application/json;jmapVersion=rfc-8621",
              "content-length": 1187
            });

        final httpClient = HttpClient(dio);
        final processingInvocation = ProcessingInvocation();
        final jmapRequestBuilder =
            JmapRequestBuilder(httpClient, processingInvocation);
        final accountId = AccountId(Id(
            '0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb'));
        // final result = await (jmapRequestBuilder).build().execute();

        // expect(result, response1);
      });
    }
  });
}
