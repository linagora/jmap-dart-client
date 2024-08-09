import 'package:dio/dio.dart';
import 'package:test/test.dart';
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
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';

void main() {
  group('get list email test', () {
    final expectMail1 = Email(
        id: EmailId(Id("382312d0-fa5c-11eb-b647-2fef1ee78d9e")),
        preview: "Dear QA,I attached image here",
        hasAttachment: false,
        subject: "test inline image",
        from: {EmailAddress("DatPH", "dphamhoang@linagora.com")},
        sentAt: UTCDate(DateTime.parse("2021-08-11T04:25:34Z")),
        receivedAt: UTCDate(DateTime.parse("2021-08-11T04:25:55Z"))
    );

    final expectMail2 = Email(
        id: EmailId(Id("bc8a5320-fa58-11eb-b647-2fef1ee78d9e")),
        preview: "This event is about to begin Noti check TimeFriday 23 October 2020 12:00 - 12:30 Europe/Paris (See in Calendar)Location1 thai ha (See in Map)Attendees - User A <usera@qa.open-paas.org> (Organizer) - Lê Nguyễn <userb@qa.open-paas.org> - User C <userc@qa.ope",
        hasAttachment: false,
        subject: "Notification: Noti check",
        from: {EmailAddress(null, "noreply@qa.open-paas.org")},
        sentAt: UTCDate(DateTime.parse("2021-08-10T09:45:01Z")),
        receivedAt: UTCDate(DateTime.parse("2021-08-11T04:00:59Z"))
    );

    final expectMail3 = Email(
        id: EmailId(Id("ba7e0860-fa58-11eb-b647-2fef1ee78d9e")),
        preview: "This event is about to begin Recurrencr TimeWednesday 26 August 2020 05:30 - 06:30 Europe/Paris (See in Calendar)Location1 thai ha (See in Map)Attendees - userb@qa.open-paas.org <userb@qa.open-paas.org> (Organizer) - User A <usera@qa.open-paas.org> Resourc",
        hasAttachment: false,
        subject: "Notification: Recurrencr",
        from: {EmailAddress(null, "noreply@qa.open-paas.org")},
        sentAt: UTCDate(DateTime.parse("2021-08-11T03:00:00Z")),
        receivedAt: UTCDate(DateTime.parse("2021-08-11T04:00:55Z"))
    );

    final expectMail4 = Email(
        id: EmailId(Id("d9b3b880-fa6f-11eb-b647-2fef1ee78d9e")),
        preview: "alo -- desktop signature",
        hasAttachment: true,
        subject: "test attachment",
        from: {EmailAddress("Haaheoo", "userc@qa.open-paas.org")},
        sentAt: UTCDate(DateTime.parse("2021-08-11T06:46:25Z")),
        receivedAt: UTCDate(DateTime.parse("2021-08-11T06:46:26Z"))
    );

    final expectMail5 = Email(
        id: EmailId(Id("637f1ef0-fa5d-11eb-b647-2fef1ee78d9e")),
        preview: "Dear, test inline Thanks and BRs-- desktop signature",
        hasAttachment: false,
        subject: "test inline image",
        from: {EmailAddress("Haaheoo", "userc@qa.open-paas.org")},
        sentAt: UTCDate(DateTime.parse("2021-08-11T04:34:13Z")),
        receivedAt: UTCDate(DateTime.parse("2021-08-11T04:34:17Z"))
    );

    test('get email in a mailbox correctly', () async {
      final baseOption  = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)
        ..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onPost(
          '',
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
                      "preview": "Dear QA,I attached image here",
                      "hasAttachment": false,
                      "subject": "test inline image",
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
                      "preview": "This event is about to begin Noti check TimeFriday 23 October 2020 12:00 - 12:30 Europe/Paris (See in Calendar)Location1 thai ha (See in Map)Attendees - User A <usera@qa.open-paas.org> (Organizer) - Lê Nguyễn <userb@qa.open-paas.org> - User C <userc@qa.ope",
                      "hasAttachment": false,
                      "subject": "Notification: Noti check",
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
                      "preview": "This event is about to begin Recurrencr TimeWednesday 26 August 2020 05:30 - 06:30 Europe/Paris (See in Calendar)Location1 thai ha (See in Map)Attendees - userb@qa.open-paas.org <userb@qa.open-paas.org> (Organizer) - User A <usera@qa.open-paas.org> Resourc",
                      "hasAttachment": false,
                      "subject": "Notification: Recurrencr",
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
                      "preview": "alo -- desktop signature",
                      "hasAttachment": true,
                      "subject": "test attachment",
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
                      "preview": "Dear, test inline Thanks and BRs-- desktop signature",
                      "hasAttachment": false,
                      "subject": "test inline image",
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
                  "accountId": "93c56f4408cff66f0a929aea8e3940e753c3275e5622582ae3010e7277b7696c",
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
                  "accountId": "93c56f4408cff66f0a929aea8e3940e753c3275e5622582ae3010e7277b7696c",
                  "#ids": {
                    "resultOf": "c2",
                    "name": "Email/query",
                    "path": "/ids/*"
                  },
                  "properties": [
                    "id",
                    "subject",
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
            "content-length": 1187
          }
      );

      final httpClient = HttpClient(dio);
      final processingInvocation = ProcessingInvocation();
      final jmapRequestBuilder = JmapRequestBuilder(httpClient, processingInvocation);
      final accountId = AccountId(Id('93c56f4408cff66f0a929aea8e3940e753c3275e5622582ae3010e7277b7696c'));

      final queryEmailMethod = QueryEmailMethod(accountId)
        ..addLimit(UnsignedInt(20))
        ..addSorts({EmailComparator(EmailComparatorProperty.sentAt)..setIsAscending(false)})
        ..addFilters(EmailFilterCondition(inMailbox: MailboxId((Id('aba7e8d0-18d9-11eb-a677-2990b970028d')))));
      final queryEmailInvocation = jmapRequestBuilder.invocation(queryEmailMethod, methodCallId: MethodCallId('c2'));

      final getEmailMethod = GetEmailMethod(accountId)
        ..addProperties(Properties({"id", "subject", "from", "receivedAt", "sentAt", "preview", "hasAttachment"}))
        ..addReferenceIds(
            processingInvocation.createResultReference(
                queryEmailInvocation.methodCallId,
                ReferencePath.idsPath));
      final getEmailInvocation = jmapRequestBuilder.invocation(getEmailMethod, methodCallId: MethodCallId('c3'));

      final result = await (jmapRequestBuilder
        ..usings(getEmailMethod.requiredCapabilities))
          .build()
          .execute();

      final resultList = result.parse<GetEmailResponse>(
          getEmailInvocation.methodCallId, GetEmailResponse.deserialize);

      expect(resultList?.list.length, equals(5));
      expect(resultList?.list, containsAll({expectMail1, expectMail2, expectMail3, expectMail4, expectMail5}));
    });
  });
}