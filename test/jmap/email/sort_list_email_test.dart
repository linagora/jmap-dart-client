
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

  final expectMail1 = Email(
      EmailId(Id("382312d0-fa5c-11eb-b647-2fef1ee78d9e")),
      preview: "Dear QA,I attached image here",
      hasAttachment: false,
      subject: "A",
      size: UnsignedInt(10001),
      from: {EmailAddress("DatPH", "dphamhoang@linagora.com")},
      sentAt: UTCDate(DateTime.parse("2021-08-11T04:25:34Z")),
      receivedAt: UTCDate(DateTime.parse("2021-08-11T04:25:55Z"))
  );

  final expectMail2 = Email(
      EmailId(Id("bc8a5320-fa58-11eb-b647-2fef1ee78d9e")),
      preview: "This event is about to begin Noti check TimeFriday 23 October 2020 12:00 - 12:30 Europe/Paris (See in Calendar)Location1 thai ha (See in Map)Attendees - User A <usera@qa.open-paas.org> (Organizer) - Lê Nguyễn <userb@qa.open-paas.org> - User C <userc@qa.ope",
      hasAttachment: false,
      subject: "B",
      size: UnsignedInt(10002),
      from: {EmailAddress(null, "noreply@qa.open-paas.org")},
      sentAt: UTCDate(DateTime.parse("2021-08-10T09:45:01Z")),
      receivedAt: UTCDate(DateTime.parse("2021-08-11T04:00:59Z"))
  );

  final expectMail3 = Email(
      EmailId(Id("ba7e0860-fa58-11eb-b647-2fef1ee78d9e")),
      preview: "This event is about to begin Recurrencr TimeWednesday 26 August 2020 05:30 - 06:30 Europe/Paris (See in Calendar)Location1 thai ha (See in Map)Attendees - userb@qa.open-paas.org <userb@qa.open-paas.org> (Organizer) - User A <usera@qa.open-paas.org> Resourc",
      hasAttachment: false,
      subject: "C",
      size: UnsignedInt(10003),
      from: {EmailAddress(null, "noreply@qa.open-paas.org")},
      sentAt: UTCDate(DateTime.parse("2021-08-11T03:00:00Z")),
      receivedAt: UTCDate(DateTime.parse("2021-08-11T04:00:55Z"))
  );

  final expectMail4 = Email(
      EmailId(Id("d9b3b880-fa6f-11eb-b647-2fef1ee78d9e")),
      preview: "alo -- desktop signature",
      hasAttachment: true,
      subject: "D",
      size: UnsignedInt(10004),
      from: {EmailAddress("Haaheoo", "userc@qa.open-paas.org")},
      sentAt: UTCDate(DateTime.parse("2021-08-11T06:46:25Z")),
      receivedAt: UTCDate(DateTime.parse("2021-08-11T06:46:26Z"))
  );

  final expectMail5 = Email(
      EmailId(Id("637f1ef0-fa5d-11eb-b647-2fef1ee78d9e")),
      preview: "Dear, test inline Thanks and BRs-- desktop signature",
      hasAttachment: false,
      subject: "E",
      size: UnsignedInt(10005),
      from: {EmailAddress("Haaheoo", "userc@qa.open-paas.org")},
      sentAt: UTCDate(DateTime.parse("2021-08-11T04:34:13Z")),
      receivedAt: UTCDate(DateTime.parse("2021-08-11T04:34:17Z"))
  );

  Future<List<Email>?> getListEmailAndSortBy(Comparator comparator) async {
    final baseOption  = BaseOptions(method: 'POST');
    final dio = Dio(baseOption)
      ..options.baseUrl = 'http://domain.com';
    final dioAdapter = DioAdapter(dio: dio);
    dioAdapter.onPost(
        '/jmap',
            (server) => server.reply(200, {
          "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
          "methodResponses": [
            [
              "Email/query",
              {
                "accountId": "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                "queryState": "248a9026",
                "canCalculateChanges": false,
                "ids": [
                  "d9b3b880-fa6f-11eb-b647-2fef1ee78d9e",
                  "637f1ef0-fa5d-11eb-b647-2fef1ee78d9e",
                  "382312d0-fa5c-11eb-b647-2fef1ee78d9e",
                  "ba7e0860-fa58-11eb-b647-2fef1ee78d9e",
                  "bc8a5320-fa58-11eb-b647-2fef1ee78d9e"
                ],
                "position": 0
              },
              "c2"
            ],
            [
              "Email/get",
              {
                "accountId": "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                "notFound": [],
                "state": "05114a40-fa7c-11eb-a9c2-2fef1ee78d9e",
                "list": [
                  {
                    "size": 10001,
                    "preview": "Dear QA,I attached image here",
                    "hasAttachment": false,
                    "subject": "A",
                    "from": [
                      {
                        "name": "DatPH",
                        "email": "dphamhoang@linagora.com"
                      }
                    ],
                    "sentAt": "2021-08-11T04:25:34Z",
                    "id": "382312d0-fa5c-11eb-b647-2fef1ee78d9e",
                    "receivedAt": "2021-08-11T04:25:55Z"
                  },
                  {
                    "size": 10002,
                    "preview": "This event is about to begin Noti check TimeFriday 23 October 2020 12:00 - 12:30 Europe/Paris (See in Calendar)Location1 thai ha (See in Map)Attendees - User A <usera@qa.open-paas.org> (Organizer) - Lê Nguyễn <userb@qa.open-paas.org> - User C <userc@qa.ope",
                    "hasAttachment": false,
                    "subject": "B",
                    "from": [
                      {
                        "email": "noreply@qa.open-paas.org"
                      }
                    ],
                    "sentAt": "2021-08-10T09:45:01Z",
                    "id": "bc8a5320-fa58-11eb-b647-2fef1ee78d9e",
                    "receivedAt": "2021-08-11T04:00:59Z"
                  },
                  {
                    "size": 10003,
                    "preview": "This event is about to begin Recurrencr TimeWednesday 26 August 2020 05:30 - 06:30 Europe/Paris (See in Calendar)Location1 thai ha (See in Map)Attendees - userb@qa.open-paas.org <userb@qa.open-paas.org> (Organizer) - User A <usera@qa.open-paas.org> Resourc",
                    "hasAttachment": false,
                    "subject": "C",
                    "from": [
                      {
                        "email": "noreply@qa.open-paas.org"
                      }
                    ],
                    "sentAt": "2021-08-11T03:00:00Z",
                    "id": "ba7e0860-fa58-11eb-b647-2fef1ee78d9e",
                    "receivedAt": "2021-08-11T04:00:55Z"
                  },
                  {
                    "size": 10004,
                    "preview": "alo -- desktop signature",
                    "hasAttachment": true,
                    "subject": "D",
                    "from": [
                      {
                        "name": "Haaheoo",
                        "email": "userc@qa.open-paas.org"
                      }
                    ],
                    "sentAt": "2021-08-11T06:46:25Z",
                    "id": "d9b3b880-fa6f-11eb-b647-2fef1ee78d9e",
                    "receivedAt": "2021-08-11T06:46:26Z"
                  },
                  {
                    "size": 10005,
                    "preview": "Dear, test inline Thanks and BRs-- desktop signature",
                    "hasAttachment": false,
                    "subject": "E",
                    "from": [
                      {
                        "name": "Haaheoo",
                        "email": "userc@qa.open-paas.org"
                      }
                    ],
                    "sentAt": "2021-08-11T04:34:13Z",
                    "id": "637f1ef0-fa5d-11eb-b647-2fef1ee78d9e",
                    "receivedAt": "2021-08-11T04:34:17Z"
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
              "Email/query",
              {
                "accountId": "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                "filter": {
                  "inMailbox": "aba7e8d0-18d9-11eb-a677-2990b970028d"
                },
                "sort": [{
                  "isAscending": false,
                  "property":"sentAt"
                }],
                "limit": 20,
              },
              "c2"
            ],
            [
              "Email/get",
              {
                "accountId": "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
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
        }
    );

    final httpClient = HttpClient(dio);
    final processingInvocation = ProcessingInvocation();
    final jmapRequestBuilder = JmapRequestBuilder(httpClient, processingInvocation);
    final accountId = AccountId(Id('3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12'));

    final queryEmailMethod = QueryEmailMethod(accountId)
      ..addLimit(UnsignedInt(20))
      ..addSorts({EmailComparator(EmailComparatorProperty.sentAt)..setIsAscending(false)})
      ..addFilters(EmailFilterCondition(inMailbox: MailboxId((Id('aba7e8d0-18d9-11eb-a677-2990b970028d')))));
    final queryEmailInvocation = jmapRequestBuilder.invocation(queryEmailMethod, methodCallId: MethodCallId('c2'));

    final getEmailMethod = GetEmailMethod(accountId)
      ..addProperties(Properties({"id", "subject", "size", "from", "receivedAt", "sentAt", "preview", "hasAttachment"}))
      ..addReferenceIds(processingInvocation.createResultReference(queryEmailInvocation.methodCallId, ReferencePath.idsPath));
    final getEmailInvocation = jmapRequestBuilder.invocation(getEmailMethod, methodCallId: MethodCallId('c3'));

    final result = await (jmapRequestBuilder
        ..usings(getEmailMethod.requiredCapabilities))
      .build()
      .execute();

    final resultList = result.parse<GetEmailResponse>(
        getEmailInvocation.methodCallId, GetEmailResponse.deserialize);

    if (resultList != null) {
      resultList..sortEmails(comparator);
    }

    return resultList?.list;
  }

  group('sort list email test', () {

    test('sort list email by receivedAt descending', () async {
      final listEmailResponse = await getListEmailAndSortBy(EmailComparator(EmailComparatorProperty.receivedAt)..setIsAscending(false));
      expect(listEmailResponse, containsAllInOrder([expectMail4, expectMail5, expectMail1, expectMail2, expectMail3]));
    });

    test('sort list email by receivedAt ascending', () async {
      final listEmailResponse = await getListEmailAndSortBy(EmailComparator(EmailComparatorProperty.receivedAt)..setIsAscending(true));
      expect(listEmailResponse, containsAllInOrder([expectMail3, expectMail2, expectMail1, expectMail5, expectMail4]));
    });

    test('sort list email by sentAt descending', () async {
      final listEmailResponse = await getListEmailAndSortBy(EmailComparator(EmailComparatorProperty.sentAt)..setIsAscending(false));
      expect(listEmailResponse, containsAllInOrder([expectMail4, expectMail5, expectMail1, expectMail3, expectMail2]));
    });

    test('sort list email by sentAt ascending', () async {
      final listEmailResponse = await getListEmailAndSortBy(EmailComparator(EmailComparatorProperty.sentAt)..setIsAscending(true));
      expect(listEmailResponse, containsAllInOrder([expectMail2, expectMail3, expectMail1, expectMail5, expectMail4]));
    });

    test('sort list email by subject descending', () async {
      final listEmailResponse = await getListEmailAndSortBy(EmailComparator(EmailComparatorProperty.subject)..setIsAscending(false));
      expect(listEmailResponse, containsAllInOrder([expectMail5, expectMail4, expectMail3, expectMail2, expectMail1]));
    });

    test('sort list email by subject ascending', () async {
      final listEmailResponse = await getListEmailAndSortBy(EmailComparator(EmailComparatorProperty.subject)..setIsAscending(true));
      expect(listEmailResponse, containsAllInOrder([expectMail1, expectMail2, expectMail3, expectMail4, expectMail5]));
    });

    test('sort list email by size descending', () async {
      final listEmailResponse = await getListEmailAndSortBy(EmailComparator(EmailComparatorProperty.size)..setIsAscending(false));
      expect(listEmailResponse, containsAllInOrder([expectMail5, expectMail4, expectMail3, expectMail2, expectMail1]));
    });

    test('sort list email by size ascending', () async {
      final listEmailResponse = await getListEmailAndSortBy(EmailComparator(EmailComparatorProperty.size)..setIsAscending(true));
      expect(listEmailResponse, containsAllInOrder([expectMail1, expectMail2, expectMail3, expectMail4, expectMail5]));
    });
  });
}