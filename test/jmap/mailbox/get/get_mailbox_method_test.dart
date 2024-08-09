import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/get/get_mailbox_method.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/get/get_mailbox_response.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox_rights.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/namespace.dart';

void main() {
  group('test to json get mailbox method', () {
    final expectedMailbox1 = Mailbox(
      id: MailboxId(Id('f1cef2d0-30a9-11eb-9a8d-254ee97830fe')),
      role: Role('inbox'),
      name: MailboxName('INBOX'),
      sortOrder: SortOrder(sortValue: 10),
      totalEmails: TotalEmails(UnsignedInt(1847)),
      unreadEmails: UnreadEmails(UnsignedInt(1708)),
      totalThreads: TotalThreads(UnsignedInt(1847)),
      unreadThreads: UnreadThreads(UnsignedInt(1708)),
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
      isSubscribed: IsSubscribed(false),
      rights: {
        "firstname23.surname23@upn.integration-open-paas.org": [
          "i",
          "l",
          "r",
          "s",
          "t",
          "w"
        ]
      },
      namespace: Namespace('Personal')
    );

    final expectedMailbox2 = Mailbox(
      id: MailboxId(Id('f1cef2d0-30a9-11eb-9a8d-254ee97830fe')),
      role: Role('inbox'),
      name: MailboxName('INBOX'),
      sortOrder: SortOrder(sortValue: 10),
      totalEmails: TotalEmails(UnsignedInt(1847)),
      unreadEmails: UnreadEmails(UnsignedInt(1708)),
      totalThreads: TotalThreads(UnsignedInt(1847)),
      unreadThreads: UnreadThreads(UnsignedInt(1708)),
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
      isSubscribed: IsSubscribed(false)
    );

    test('get mailbox method and response parsing has team mailboxes', () async {
      final baseOption  = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)
        ..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
      dioAdapter.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
          "methodResponses": [
            [
              "Mailbox/get",
              {
                "accountId": "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555",
                "notFound": [

                ],
                "state": "c7b1bb10-80f5-11ed-b960-5773e4d60b2f",
                "list": [
                  {
                    "totalThreads": 1847,
                    "name": "INBOX",
                    "isSubscribed": false,
                    "role": "inbox",
                    "totalEmails": 1847,
                    "unreadThreads": 1708,
                    "unreadEmails": 1708,
                    "sortOrder": 10,
                    "rights": {
                      "firstname23.surname23@upn.integration-open-paas.org": [
                        "i",
                        "l",
                        "r",
                        "s",
                        "t",
                        "w"
                      ]
                    },
                    "namespace": "Personal",
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
                    "id": "f1cef2d0-30a9-11eb-9a8d-254ee97830fe"
                  }
                ]
              },
              "c0"
            ]
          ]
        }),
        data: {
          "using": [
            "urn:ietf:params:jmap:core",
            "urn:ietf:params:jmap:mail",
            "urn:apache:james:params:jmap:mail:shares"
          ],
          "methodCalls": [
            [
              "Mailbox/get",
              {
                "accountId": "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555"
              },
              "c0"
            ]
          ]
        },
        headers: {
          "accept": "application/json;jmapVersion=rfc-8621",
          "content-length": 299
        }
      );

      final getMailboxMethod = GetMailboxMethod(AccountId(Id('0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555')));
      final httpClient = HttpClient(dio);
      final requestBuilder = JmapRequestBuilder(httpClient, ProcessingInvocation());
      final getMailboxInvocation = requestBuilder.invocation(getMailboxMethod);
      final response = await (requestBuilder
          ..usings(getMailboxMethod.requiredCapabilitiesSupportTeamMailboxes))
        .build()
        .execute();

      final getMailboxResponse = response.parse<GetMailboxResponse>(
        getMailboxInvocation.methodCallId,
        GetMailboxResponse.deserialize);

      expect(getMailboxResponse?.list.length, equals(1));
      expect(getMailboxResponse?.list, containsAll([expectedMailbox1]));
    });

    test('get mailbox method and response parsing not have team mailboxes', () async {
      final baseOption  = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)
        ..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
      dioAdapter.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
          "methodResponses": [
            [
              "Mailbox/get",
              {
                "accountId": "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555",
                "notFound": [

                ],
                "state": "c7b1bb10-80f5-11ed-b960-5773e4d60b2f",
                "list": [
                  {
                    "totalThreads": 1847,
                    "name": "INBOX",
                    "isSubscribed": false,
                    "role": "inbox",
                    "totalEmails": 1847,
                    "unreadThreads": 1708,
                    "unreadEmails": 1708,
                    "sortOrder": 10,
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
                    "id": "f1cef2d0-30a9-11eb-9a8d-254ee97830fe"
                  }
                ]
              },
              "c0"
            ]
          ]
        }),
        data: {
          "using": [
            "urn:ietf:params:jmap:core",
            "urn:ietf:params:jmap:mail"
          ],
          "methodCalls": [
            [
              "Mailbox/get",
              {
                "accountId": "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555"
              },
              "c0"
            ]
          ]
        },
        headers: {
          "accept": "application/json;jmapVersion=rfc-8621",
          "content-length": 240
        }
      );

      final getMailboxMethod = GetMailboxMethod(AccountId(Id('0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555')));
      final httpClient = HttpClient(dio);
      final requestBuilder = JmapRequestBuilder(httpClient, ProcessingInvocation());
      final getMailboxInvocation = requestBuilder.invocation(getMailboxMethod);
      final response = await (requestBuilder
          ..usings(getMailboxMethod.requiredCapabilities))
        .build()
        .execute();

      final getMailboxResponse = response.parse<GetMailboxResponse>(
        getMailboxInvocation.methodCallId,
        GetMailboxResponse.deserialize);

      expect(getMailboxResponse?.list.length, equals(1));
      expect(getMailboxResponse?.list, containsAll([expectedMailbox2]));
    });
  });
}