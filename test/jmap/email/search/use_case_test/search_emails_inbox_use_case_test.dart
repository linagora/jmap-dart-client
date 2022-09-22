import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/properties/properties.dart';
import 'package:jmap_dart_client/jmap/core/request/reference_path.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/sort/comparator.dart';
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
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';

void main() {
  final expectMail1 = Email(EmailId(Id("5baf2a10-3f4d-11eb-b3ca-69d8f333e2f2")),
      preview:
          "DJ REPEAT:Ercot Sees 56,373 MW Summer Peak,2% Below '00 Peak DJ Ercot: New Units Will Boost Supply to 65,064 MW DJ Ercot: 21% Summer Reserve If Normal Weather DJ Ercot Summer -2: New 345-Kv Line To Relieve Congestion By Eileen O'Grady Of DOW JONES NEWSWIRE",
      hasAttachment: false,
      subject: "FYI: Ercot summer assessment",
      size: UnsignedInt(5306),
      from: {
        EmailAddress(
          "O'Grady  Eileen",
          "eileen.ogrady@dowjones.com",
        )
      },
      sentAt: UTCDate(DateTime.parse(
        "2001-05-01T19:40:00Z",
      )),
      receivedAt: UTCDate(DateTime.parse(
        "2020-12-16T03:18:24Z",
      )));

  final expectMail2 = Email(EmailId(Id("2ef049e0-3f5d-11eb-bf20-f1a8da6866c8")),
      preview:
          "---------------------- Forwarded by Lorna Brennan/ET&S/Enron on 12/18/2000 10:59 AM --------------------------- \"Webmaster@cera.com\" <webmaster on 12/15/2000 06:15:19 PM To: cc: Subject: STRATOSPHERIC LEVELS -- CERA Monthly Briefing Title: Into the Stratos",
      hasAttachment: false,
      subject: "STRATOSPHERIC LEVELS -- CERA Monthly Briefing",
      size: UnsignedInt(3209),
      sentAt: UTCDate(DateTime.parse(
        "2000-12-18T19:04:00Z",
      )),
      receivedAt: UTCDate(DateTime.parse(
        "2020-12-16T05:11:41Z",
      )));

  final expectMail3 = Email(EmailId(Id("2ef049e0-3f5d-11eb-bf20-f1a8da6866c8")),
      preview:
          "---------------------- Forwarded by Lorna Brennan/ET&S/Enron on 12/18/2000 10:59 AM --------------------------- \"Webmaster@cera.com\" <webmaster on 12/15/2000 06:15:19 PM To: cc: Subject: STRATOSPHERIC LEVELS -- CERA Monthly Briefing Title: Into the Stratos",
      hasAttachment: false,
      subject: "STRATOSPHERIC LEVELS -- CERA Monthly Briefing",
      size: UnsignedInt(3209),
      sentAt: UTCDate(DateTime.parse(
        "2000-12-18T19:04:00Z",
      )),
      receivedAt: UTCDate(DateTime.parse(
        "2020-12-16T05:11:41Z",
      )));

  Future<List<Email>?> searchMailByCondition(Comparator comparator) async {
    final baseOption = BaseOptions(method: 'POST');
    final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
    final dioAdapter = DioAdapter(dio: dio);
    dioAdapter.onPost(
        '',
        (server) => server.reply(200, {
              "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
              "methodResponses": [
                [
                  "Email/query",
                  {
                    "accountId":
                        "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
                    "queryState": "c9ea66e6",
                    "canCalculateChanges": false,
                    "ids": [
                      "5baf2a10-3f4d-11eb-b3ca-69d8f333e2f2",
                      "2ef049e0-3f5d-11eb-bf20-f1a8da6866c8",
                      "eb971e70-3f5d-11eb-99e6-e9eb8e56f928"
                    ],
                    "position": 0
                  },
                  "c2"
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
                        "preview":
                            "DJ REPEAT:Ercot Sees 56,373 MW Summer Peak,2% Below '00 Peak DJ Ercot: New Units Will Boost Supply to 65,064 MW DJ Ercot: 21% Summer Reserve If Normal Weather DJ Ercot Summer -2: New 345-Kv Line To Relieve Congestion By Eileen O'Grady Of DOW JONES NEWSWIRE",
                        "hasAttachment": false,
                        "size": 5306,
                        "subject": "FYI: Ercot summer assessment",
                        "from": [
                          {
                            "name": "O'Grady  Eileen",
                            "email": "eileen.ogrady@dowjones.com"
                          }
                        ],
                        "sentAt": "2001-05-01T19:40:00Z",
                        "id": "5baf2a10-3f4d-11eb-b3ca-69d8f333e2f2",
                        "receivedAt": "2020-12-16T03:18:24Z"
                      },
                      {
                        "preview":
                            "---------------------- Forwarded by Lorna Brennan/ET&S/Enron on 12/18/2000 10:59 AM --------------------------- \"Webmaster@cera.com\" <webmaster on 12/15/2000 06:15:19 PM To: cc: Subject: STRATOSPHERIC LEVELS -- CERA Monthly Briefing Title: Into the Stratos",
                        "hasAttachment": false,
                        "size": 3209,
                        "subject":
                            "STRATOSPHERIC LEVELS -- CERA Monthly Briefing",
                        "sentAt": "2000-12-18T19:04:00Z",
                        "id": "2ef049e0-3f5d-11eb-bf20-f1a8da6866c8",
                        "receivedAt": "2020-12-16T05:11:41Z"
                      },
                      {
                        "preview":
                            "I wanted to introduce myself and let you know that the Portland West Desk has a new person in Deal Control. I'm sure you know from working with Carla Hoffman that the position requires quite a bit of communication with your group regarding Enpower program ",
                        "hasAttachment": false,
                        "size": 2636,
                        "subject": "Enron Online Report",
                        "sentAt": "2000-12-07T19:46:00Z",
                        "id": "eb971e70-3f5d-11eb-99e6-e9eb8e56f928",
                        "receivedAt": "2020-12-16T05:16:58Z"
                      }
                    ]
                  },
                  "c3"
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
                  "inMailbox": "c2543650-32cf-11eb-995c-a3ae66e9f96a",
                  "text": "report"
                },
                "limit": 3
              },
              "c2"
            ],
            [
              "Email/get",
              {
                "accountId":
                    "0eacc7a5c74b27ab36a823bc5c34da36e16c093705f241d6ed5f48ee73a4ecfb",
                "#ids": {
                  "resultOf": "c2",
                  "name": "Email/query",
                  "path": "/ids/*"
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
              "c3"
            ]
          ]
        },
        headers: {
          "accept": "application/json;jmapVersion=rfc-8621",
          "content-type": "application/json; charset=utf-8"
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
      ..addLimit(UnsignedInt(3))
      ..addFilters(
        EmailFilterCondition(
          text: 'report',
          inMailbox: MailboxId(
            Id('c2543650-32cf-11eb-995c-a3ae66e9f96a'),
          ),
        ),
      );

    final queryEmailInvocation = jmapRequestBuilder.invocation(queryEmailMethod,
        methodCallId: MethodCallId('c2'));

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
    final getEmailInvocation = jmapRequestBuilder.invocation(
      getEmailMethod,
      methodCallId: MethodCallId('c3'),
    );

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
    test('Search emails in Inbox which have the string report', () async {
      final listEmailResponse = await searchMailByCondition(
          EmailComparator(EmailComparatorProperty.sentAt)
            ..setIsAscending(false));
      expect(
        listEmailResponse,
        containsAllInOrder([expectMail1, expectMail2]),
      );
    });

    test('Search emails in Inbox which have the string report fail', () async {
      final listEmailResponse = await searchMailByCondition(
          EmailComparator(EmailComparatorProperty.sentAt)
            ..setIsAscending(false));
      expect(
        listEmailResponse,
        isNot(equals([expectMail1, expectMail2, expectMail3])),
      );
    });
  });
}
