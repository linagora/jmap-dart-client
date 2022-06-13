import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/properties/properties.dart';
import 'package:jmap_dart_client/jmap/core/request/reference_path.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/core/utc_date.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_address.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_comparator.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_comparator_property.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_filter_condition.dart';
import 'package:jmap_dart_client/jmap/mail/email/get/get_email_method.dart';
import 'package:jmap_dart_client/jmap/mail/email/get/get_email_response.dart';
import 'package:jmap_dart_client/jmap/mail/email/query/query_email_method.dart';
import 'package:jmap_dart_client/jmap/core/sort/comparator.dart';

void main() {
  final expectMail = Email(EmailId(Id("04f27c50-e879-11ec-aae4-43ebf0340ebd")),
      preview: "AAAA",
      hasAttachment: false,
      subject: "AAAA",
      size: UnsignedInt(3328),
      from: {EmailAddress("Manh tuan Manh", "manh199672@gmail.com")},
      sentAt: UTCDate(DateTime.parse("2022-06-10T04:44:03Z")),
      receivedAt: UTCDate(DateTime.parse("2022-06-10T04:51:41Z")));

  Future<List<Email>?> searchMailByCondition(Comparator comparator) async {
    final baseOption = BaseOptions(method: 'POST');
    final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com';
    final dioAdapter = DioAdapter(dio: dio);
    dioAdapter.onPost(
        '/jmap',
        (server) => server.reply(200, {
              "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
              "methodResponses": [
                [
                  "Email/query",
                  {
                    "accountId":
                        "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
                    "queryState": "c4a08240",
                    "canCalculateChanges": false,
                    "ids": ["04f27c50-e879-11ec-aae4-43ebf0340ebd"],
                    "position": 0,
                    "limit": 256
                  },
                  "c1"
                ],
                [
                  "Email/get",
                  {
                    "accountId":
                        "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
                    "notFound": [],
                    "state": "94bbff20-e87c-11ec-aae4-43ebf0340ebd",
                    "list": [
                      {
                        "preview": "AAAA",
                        "hasAttachment": false,
                        "size": 3328,
                        "subject": "AAAA",
                        "from": [
                          {
                            "name": "Manh tuan Manh",
                            "email": "manh199672@gmail.com"
                          }
                        ],
                        "sentAt": "2022-06-10T04:44:03Z",
                        "id": "04f27c50-e879-11ec-aae4-43ebf0340ebd",
                        "receivedAt": "2022-06-10T04:51:41Z"
                      }
                    ]
                  },
                  "c2"
                ]
              ]
            }),
        data: {
          "using": ["urn:ietf:params:jmap:core", "urn:ietf:params:jmap:mail"],
          "methodCalls": [
            [
              "Email/query",
              {
                "accountId":
                    "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
                "filter": {
                  "before": "2022-04-23T00:00:00.000Z",
                  "after": "2022-01-23T00:00:00.000Z",
                  "text": "report",
                  "from": "manh"
                }
              },
              "c1"
            ],
            [
              "Email/get",
              {
                "accountId":
                    "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
                "#ids": {
                  "resultOf": "c1",
                  "name": "Email/query",
                  "path": "ids/*"
                },
                "properties": [
                  "id",
                  "subject",
                  "size",
                  "from",
                  "receivedAt",
                  "sentAt",
                  "preview",
                  "hasAttachment"
                ]
              },
              "c2"
            ]
          ]
        },
        headers: {
          "accept": "application/json;jmapVersion=rfc-8621",
          "content-type": "application/json; charset=utf-8",
        });

    final httpClient = HttpClient(dio);
    final processingInvocation = ProcessingInvocation();
    final jmapRequestBuilder = JmapRequestBuilder(
      httpClient,
      processingInvocation,
    );
    final accountId = AccountId(
      Id('0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb'),
    );

    final queryEmailMethod = QueryEmailMethod(accountId)
      ..addFilters(
        EmailFilterCondition(
            after: UTCDate(
              DateTime.parse('2022-01-23T00:00:00Z'),
            ),
            before: UTCDate(
              DateTime.parse('2022-04-23T00:00:00Z'),
            ),
            from: 'manh',
            text: 'report'),
      );
    final queryEmailInvocation = jmapRequestBuilder.invocation(
      queryEmailMethod,
      methodCallId: MethodCallId('c1'),
    );

    final getEmailMethod = GetEmailMethod(accountId)
      ..addProperties(Properties({
        "id",
        "subject",
        "size",
        "from",
        "receivedAt",
        "sentAt",
        "preview",
        "hasAttachment"
      }))
      ..addReferenceIds(processingInvocation.createResultReference(
        queryEmailInvocation.methodCallId,
        ReferencePath.idsPath,
      ));
    final getEmailInvocation = jmapRequestBuilder.invocation(getEmailMethod,
        methodCallId: MethodCallId('c2'));

    final result = await (jmapRequestBuilder
          ..usings(getEmailMethod.requiredCapabilities))
        .build()
        .execute();

    final resultList = result.parse<GetEmailResponse>(
      getEmailInvocation.methodCallId,
      GetEmailResponse.deserialize,
    );

    if (resultList != null) {
      resultList..sortEmails(comparator);
    }

    return resultList?.list;
  }

  group('search email test', () {
    test(
        'Search emails from someone which have the string report and receviedAt from 23 Jan 2022 to 23 Apr 2022',
        () async {
      final listEmailResponse = await searchMailByCondition(
          EmailComparator(EmailComparatorProperty.sentAt)
            ..setIsAscending(false));
      expect(
        listEmailResponse,
        containsAllInOrder([expectMail]),
      );
    });

    test(
        'Search emails from someone which have the string report and receviedAt from 23 Jan 2022 to 23 Apr 2022 fail',
        () async {
      final listEmailResponse = await searchMailByCondition(
          EmailComparator(EmailComparatorProperty.sentAt)
            ..setIsAscending(false));
      expect(
        listEmailResponse,
        isNot(equals([])),
      );
    });
  });
}
