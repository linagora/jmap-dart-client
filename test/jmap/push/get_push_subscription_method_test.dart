import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/push/get/get_push_subscription_method.dart';
import 'package:jmap_dart_client/jmap/push/get/get_push_subscription_response.dart';
import 'package:jmap_dart_client/jmap/push/push_subscription.dart';

void main() {
  group('test to json get pushSubscription method', () {
    final expectedGet = PushSubscription(
      id: PushSubscriptionId(Id('e50b2c1d-9553-41a3-b0a7-a7d26b599ee1')),
    );

    test('get pushSubscription method and response parsing', () async {
      final baseOption = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onPost(
          '',
          (server) => server.reply(200, {
                "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                "methodResponses": [
                  [
                    "PushSubscription/set",
                    {
                      "list": [
                        {
                          "id": "e50b2c1d-9553-41a3-b0a7-a7d26b599ee1",
                          "deviceClientId": "b37ff8001ca0",
                          "verificationCode":
                              "b210ef734fe5f439c1ca386421359f7b",
                          "expires": "2018-07-31T00:13:21Z",
                          "types": ["Todo"]
                        }
                      ],
                      "notFound": []
                    },
                    "c0"
                  ]
                ]
              }),
          data: {
            "using": ["urn:ietf:params:jmap:core"],
            "methodCalls": [
              [
                "PushSubscription/get",
                {
                  "ids": ["e50b2c1d-9553-41a3-b0a7-a7d26b599ee1"]
                },
                "c0"
              ]
            ]
          },
          headers: {
            "accept": "application/json;jmapVersion=rfc-8621",
            "content-length": 175
          });

      final getPushSubscriptionMethod = GetPushSubscriptionMethod()
        ..addIds({Id('e50b2c1d-9553-41a3-b0a7-a7d26b599ee1')});

      final httpClient = HttpClient(dio);
      final requestBuilder =
          JmapRequestBuilder(httpClient, ProcessingInvocation());
      final getPushSubscriptionInvocation =
          requestBuilder.invocation(getPushSubscriptionMethod);
      final response = await (requestBuilder
            ..usings(getPushSubscriptionMethod.requiredCapabilities))
          .build()
          .execute();

      final getPushSubscriptionResponse =
          response.parse<GetPushSubscriptionResponse>(
              getPushSubscriptionInvocation.methodCallId,
              GetPushSubscriptionResponse.deserialize);

      expect(
          getPushSubscriptionResponse!.list.first.id, equals(expectedGet.id));
    });
  });
}
