import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';

void main() {
  group("parse should succeed test", () {
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
                "29883977c13473ae7cb7678ef767cbfbaffc8a44a6e463d971d23a65c1dc4af6",
            "blobIds": ["0f9f65ab-dc7b-4146-850f-6e4881093965"]
          },
          "c1"
        ]
      ]
    };

    test('parse should succeed', () async {
      final baseOption = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onPost('', (server) => server.reply(200, requesttoparse));

      final httpClient = HttpClient(dio);
      final processingInvocation = ProcessingInvocation();
      final requestBuilder =
          JmapRequestBuilder(httpClient, processingInvocation);
      final accountId = AccountId(Id(
          '3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12'));
    });
  });
}
