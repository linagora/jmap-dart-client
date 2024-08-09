import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/request/reference_path.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/get/get_mailbox_method.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/get/get_mailbox_response.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox_filter_condition.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox_rights.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/query/query_mailbox_method.dart';

void main() {
  group('Query mailbox test', () {
    for (final serverRole in ["junk", "spam"]) {
      for (final clientRole in ["junk", "spam"]) {
        test(
            'Query Mailbox server uses ${serverRole} and client uses ${clientRole} role report',
            () async {
          final expectedReported = Mailbox(
            id: MailboxId(Id('9bf84410-32cf-11eb-995c-a3ae66e9f96a')),
            role: Role(clientRole),
            name: MailboxName('Spam'),
            sortOrder: SortOrder(sortValue: 70),
            totalEmails: TotalEmails(UnsignedInt(29)),
            unreadEmails: UnreadEmails(UnsignedInt(29)),
            totalThreads: TotalThreads(UnsignedInt(29)),
            unreadThreads: UnreadThreads(UnsignedInt(29)),
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
          final baseOption = BaseOptions(method: 'POST');
          final dio = Dio(baseOption)
            ..options.baseUrl = 'http://domain.com/jmap';
          final dioAdapter =
              DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
          dioAdapter.onPost(
              '',
              (server) => server.reply(200, {
                    "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                    "methodResponses": [
                      [
                        "Mailbox/query",
                        {
                          "accountId":
                              "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555",
                          "queryState": "a016715b",
                          "canCalculateChanges": false,
                          "ids": ["9bf84410-32cf-11eb-995c-a3ae66e9f96a"],
                          "position": 0,
                          "limit": 256
                        },
                        "c2"
                      ],
                      [
                        "Mailbox/get",
                        {
                          "accountId":
                              "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555",
                          "notFound": [],
                          "state": "210ae7f0-9036-11ed-aaac-2f661c6dc0b9",
                          "list": [
                            {
                              "totalThreads": 29,
                              "name": "Spam",
                              "isSubscribed": true,
                              "role": serverRole,
                              "totalEmails": 29,
                              "unreadThreads": 29,
                              "unreadEmails": 29,
                              "sortOrder": 70,
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
                              "id": "9bf84410-32cf-11eb-995c-a3ae66e9f96a"
                            }
                          ]
                        },
                        "c3"
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
                    "Mailbox/query",
                    {
                      "accountId":
                          "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555",
                      "filter": {"role": "Spam"},
                      "limit": 1
                    },
                    "c2"
                  ],
                  [
                    "Mailbox/get",
                    {
                      "accountId":
                          "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555",
                      "#ids": {
                        "resultOf": "c2",
                        "name": "Mailbox/query",
                        "path": "ids/*"
                      }
                    },
                    "c3"
                  ]
                ]
              },
              headers: {
                "accept": "application/json;jmapVersion=rfc-8621",
                "content-length": 672
              });

          final httpClient = HttpClient(dio);
          final processingInvocation = ProcessingInvocation();
          final jmapRequestBuilder =
              JmapRequestBuilder(httpClient, processingInvocation);
          final accountId = AccountId(Id(
              '0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555'));
          final queryMailboxMethod = QueryMailboxMethod(accountId)
            ..addFilters(MailboxFilterCondition(role: Role('Spam')))
            ..addLimit(UnsignedInt(1));
          final queryMailboxInvocation = jmapRequestBuilder
              .invocation(queryMailboxMethod, methodCallId: MethodCallId('c2'));

          final getMailBoxMethod = GetMailboxMethod(accountId)
            ..addReferenceIds(processingInvocation.createResultReference(
              queryMailboxInvocation.methodCallId,
              ReferencePath('ids/*'),
            ));
          final getMailboxInvocation = jmapRequestBuilder
              .invocation(getMailBoxMethod, methodCallId: MethodCallId('c3'));
          final result = await (jmapRequestBuilder
                ..usings(getMailBoxMethod.requiredCapabilities))
              .build()
              .execute();

          final resultList = result.parse<GetMailboxResponse>(
              getMailboxInvocation.methodCallId,
              GetMailboxResponse.deserialize);

          expect(resultList?.list.first.name?.name, 'Spam');
          expect(resultList?.list.first.role?.value, 'junk');
          expect(resultList?.list.first, equals(expectedReported));
        });
      }
    }
  });
}
