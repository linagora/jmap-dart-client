import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/request/reference_path.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/changes/changes_mailbox_method.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/get/get_mailbox_method.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/get/get_mailbox_response.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox_rights.dart';

void main() {
  group('[MailBox/changes]', () {
    final expectedUpdated = Mailbox(
      id: MailboxId(Id('c2543650-32cf-11eb-995c-a3ae66e9f96a')),
      role: Role('inbox'),
      name: MailboxName('INBOX'),
      sortOrder: SortOrder(sortValue: 10),
      totalEmails: TotalEmails(UnsignedInt(4079)),
      unreadEmails: UnreadEmails(UnsignedInt(10)),
      totalThreads: TotalThreads(UnsignedInt(4079)),
      unreadThreads: UnreadThreads(UnsignedInt(10)),
      myRights: MailboxRights(
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
      ),
      isSubscribed: IsSubscribed(true),
    );

    test('get changes email', () async {
      final baseOption = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onPost(
          '',
          (server) => server.reply(200, {
                "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                "methodResponses": [
                  [
                    "Mailbox/changes",
                    {
                      "accountId":
                          "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
                      "oldState": "94bbff21-e87c-11ec-aae4-43ebf0340ebd",
                      "newState": "4a523070-eb89-11ec-aae4-43ebf0340ebd",
                      "hasMoreChanges": false,
                      "updatedProperties": null,
                      "created": [],
                      "updated": ["c2543650-32cf-11eb-995c-a3ae66e9f96a"],
                      "destroyed": ["7dc7cb50-3f63-11eb-bf20-f1a8da6866c8"]
                    },
                    "c0"
                  ],
                  [
                    "Mailbox/get",
                    {
                      "accountId":
                          "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
                      "notFound": [],
                      "state": "4a523070-eb89-11ec-aae4-43ebf0340ebd",
                      "list": [
                        {
                          "id": "c2543650-32cf-11eb-995c-a3ae66e9f96a",
                          "name": "INBOX",
                          "role": "inbox",
                          "sortOrder": 10,
                          "totalEmails": 4079,
                          "unreadEmails": 10,
                          "totalThreads": 4079,
                          "unreadThreads": 10,
                          "myRights": {
                            "mayReadItems": true,
                            "mayAddItems": true,
                            "mayRemoveItems": true,
                            "maySetSeen": true,
                            "maySetKeywords": true,
                            "mayCreateChild": true,
                            "mayRename": true,
                            "mayDelete": true,
                            "maySubmit": true
                          },
                          "isSubscribed": true
                        }
                      ]
                    },
                    "c1"
                  ],
                  [
                    "Mailbox/get",
                    {
                      "accountId":
                          "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
                      "notFound": ["7dc7cb50-3f63-11eb-bf20-f1a8da6866c8"],
                      "state": "4a523070-eb89-11ec-aae4-43ebf0340ebd",
                      "list": []
                    },
                    "c2"
                  ]
                ]
              }),
          data: {
            "using": ["urn:ietf:params:jmap:core", "urn:ietf:params:jmap:mail"],
            "methodCalls": [
              [
                "Mailbox/changes",
                {
                  "accountId":
                      "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
                  "sinceState": "94bbff21-e87c-11ec-aae4-43ebf0340ebd"
                },
                "c0"
              ],
              [
                "Mailbox/get",
                {
                  "accountId":
                      "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
                  "#ids": {
                    "resultOf": "c0",
                    "name": "Mailbox/changes",
                    "path": "/updated/*"
                  }
                },
                "c1"
              ],
              [
                "Mailbox/get",
                {
                  "accountId": "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
                  "#ids": {
                    "resultOf": "c0",
                    "name": "Mailbox/changes",
                    "path": "/destroyed/*"
                  }
                },
                "c2"
              ]
            ]
          },
          headers: {
            "accept": "application/json;jmapVersion=rfc-8621",
            "content-length": 1019
          });

      final HttpClient httpClient = HttpClient(dio);
      final processingInvocation = ProcessingInvocation();
      final jmapRequestBuilder =
          JmapRequestBuilder(httpClient, processingInvocation);
      final accountId = AccountId(Id(
          '0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb'));
      final state = State('94bbff21-e87c-11ec-aae4-43ebf0340ebd');

      final changesMailboxMethod = ChangesMailboxMethod(accountId, state);
      final changesMailboxInvocation = jmapRequestBuilder.invocation(
        changesMailboxMethod,
        methodCallId: MethodCallId('c0'),
      );

      final getMailboxMethodForUpdate = GetMailboxMethod(accountId)
        ..addReferenceIds(processingInvocation.createResultReference(
          changesMailboxInvocation.methodCallId,
          ReferencePath.updatedPath,
        ));

      final getMailboxForUpdateInvocation = jmapRequestBuilder.invocation(
          getMailboxMethodForUpdate,
          methodCallId: MethodCallId('c1'));

      final getMailboxMethodForDestroyed = GetMailboxMethod(accountId)
        ..addReferenceIds(processingInvocation.createResultReference(
          changesMailboxInvocation.methodCallId,
          ReferencePath('/destroyed/*'),
        ));
      final getMailboxForDestroyInvocation = jmapRequestBuilder.invocation(
        getMailboxMethodForDestroyed,
        methodCallId: MethodCallId('c2'),
      );

      final result = await (jmapRequestBuilder
            ..usings(getMailboxMethodForUpdate.requiredCapabilities))
          .build()
          .execute();

      final resultUpdated = result.parse<GetMailboxResponse>(
          getMailboxForUpdateInvocation.methodCallId,
          GetMailboxResponse.deserialize);

      final resultDestroyed = result.parse<GetMailboxResponse>(
          getMailboxForDestroyInvocation.methodCallId,
          GetMailboxResponse.deserialize);

      expect(resultUpdated!.list[0], equals(expectedUpdated));
      expect(resultDestroyed!.list.length, equals(0));
    });
  });
}
