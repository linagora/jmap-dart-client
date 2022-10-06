import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/identities/identity.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mdn/mdn.dart';
import 'package:jmap_dart_client/jmap/mdn/send/send_message_method.dart';
import 'package:jmap_dart_client/jmap/mdn/send/send_message_response.dart';

void main() {
  group('test mdn: mdn/send method', () {
    test('send message method', () async {
      final baseOption = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onPost('', (server) {
        server.reply(200, {
          "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
          "methodResponses": [
              [
                  "MDN/send",
                  {
                      "accountId": "587a9c5a4a9c0a4d36243b7417700d5383cbbfa25f0909ab7f6f4baaa5bfde9b",
                      "sent": {
                          "k1546": {
                              "originalRecipient": "rfc822; qkdo@linagora.com",
                              "finalRecipient": "rfc822; qkdo@linagora.com",
                              "includeOriginalMessage": false
                          }
                      }
                  },
                  "0"
              ],
              [
                  "Email/set",
                  {
                      "accountId": "587a9c5a4a9c0a4d36243b7417700d5383cbbfa25f0909ab7f6f4baaa5bfde9b",
                      "oldState": "4cc97ad0-4556-11ed-8e29-f124be490f0b",
                      "newState": "4cc97ad0-4556-11ed-8e29-f124be490f0b",
                      "updated": {
                          "469e31f0-4556-11ed-8e29-f124be490f0b": null
                      }
                  },
                  "0"
              ]
          ]
      });
      }, data: {
        "using": [
          "urn:ietf:params:jmap:mail",
          "urn:ietf:params:jmap:mdn",
          "urn:ietf:params:jmap:core"
        ],
        "methodCalls": [
          [
            "MDN/send",
            {
              "accountId": "587a9c5a4a9c0a4d36243b7417700d5383cbbfa25f0909ab7f6f4baaa5bfde9b",
              "identityId": "9b793b34-b2a3-3289-8aee-50e1832a602c",
              "send": {
                "k1546": {
                  "forEmailId": "469e31f0-4556-11ed-8e29-f124be490f0b",
                  "subject": "Subject MDN/send",
                  "textBody": "Hello MDN/send",
                  "disposition": {
                    "actionMode": "manual-action",
                    "sendingMode": "mdn-sent-manually",
                    "type": "displayed"
                  }
                }
              },
              "onSuccessUpdateEmail": {
                "#k1546": {"keywords/\$mdnsent": true}
              }
            },
            "0"
          ]
        ]
      }, headers: {
        "accept": "application/json;jmapVersion=rfc-8621",
        "content-type": "application/json; charset=utf-8"
      });

      final sendMessageMethod = SendMessageMethod(
          AccountId(Id('587a9c5a4a9c0a4d36243b7417700d5383cbbfa25f0909ab7f6f4baaa5bfde9b')),
          identityId: IdentityId(Id('9b793b34-b2a3-3289-8aee-50e1832a602c')),
          send: {
            Id('k1546'): Mdn.fromJson({
              "forEmailId": "469e31f0-4556-11ed-8e29-f124be490f0b",
              "subject": "Subject MDN/send",
              "textBody": "Hello MDN/send",
              "disposition": {
                "actionMode": "manual-action",
                "sendingMode": "mdn-sent-manually",
                "type": "displayed"
              }
            })
          },
          onSuccessUpdateEmail: {
            Id('k1546'): PatchObject({
              "keywords/\$mdnsent": true,
            })
          });


      final httpClient = HttpClient(dio);
      final requestBuilder = JmapRequestBuilder(httpClient, ProcessingInvocation());
      final sendMessageInvocation = requestBuilder.invocation(sendMessageMethod, methodCallId: MethodCallId('0'));
      final response =
          await (requestBuilder..usings(sendMessageMethod.requiredCapabilities)).build().execute();

      final sendMessageResponse = response.parse<SendMessageResponse>(sendMessageInvocation.methodCallId, SendMessageResponse.deserialize);
    
      expect(sendMessageResponse!.notSent, equals(null));
    });
  });
}
