import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/properties/properties.dart';
import 'package:jmap_dart_client/jmap/core/request/reference_path.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/core/utc_date.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/email/changes/changes_email_method.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_address.dart';
import 'package:jmap_dart_client/jmap/mail/email/get/get_email_method.dart';
import 'package:jmap_dart_client/jmap/mail/email/get/get_email_response.dart';
import 'package:jmap_dart_client/jmap/mail/email/keyword_identifier.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';

void main() {
  group('[Email/changes]', () {

    final expectMail1 = Email(
      id: EmailId(Id("a59d5ca0-258e-11ec-a759-2fef1ee78d9e")),
      mailboxIds: { MailboxId(Id('aba7e8d0-18d9-11eb-a677-2990b970028d')): true },
      keywords: { KeyWordIdentifier.emailSeen: true}
    );

    final expectMail2 = Email(
        id: EmailId(Id("a59d5ca0-258e-11ec-a759-2fef1ee78d9e")),
        preview: "This event is about to begin test TimeTuesday 29 September 2020 06:00 - 06:30 Europe/Paris (See in Calendar)Location1 thai ha (See in Map)Attendees - User A <usera@qa.open-paas.org> (Organizer) -  <userb@qa.open-paas.org> Resourcesnew directoryNotesaaaa *#",
        hasAttachment: false,
        size: UnsignedInt(24946),
        subject: "Notification: test",
        keywords: { KeyWordIdentifier.emailSeen: true},
        from: {EmailAddress(null, "noreply@qa.open-paas.org")},
        to: {EmailAddress(null, "userb@qa.open-paas.org")},
        sentAt: UTCDate(DateTime.parse("2021-10-05T03:45:01Z")),
        receivedAt: UTCDate(DateTime.parse("2021-10-05T03:45:13Z"))
    );

    final expectMail3 = Email(
        id: EmailId(Id("54fa3000-2595-11ec-a759-2fef1ee78d9e")),
        preview: "This event is about to begin A - show datetime1 TimeTuesday 15 September 2020 07:03 - 07:33 Europe/Paris (See in Calendar)Location1 thai ha1 (See in Map)Attendees - User A <usera@qa.open-paas.org> (Organizer) - Thanh Loan LE <tlle@linagora.com> - User C <u",
        hasAttachment: false,
        size: UnsignedInt(24857),
        subject: "Notification: A - show datetime1",
        keywords: {},
        from: {EmailAddress(null, "noreply@qa.open-paas.org")},
        to: {EmailAddress(null, "userb@qa.open-paas.org")},
        sentAt: UTCDate(DateTime.parse("2021-10-05T04:33:01Z")),
        receivedAt: UTCDate(DateTime.parse("2021-10-05T04:33:04Z"))
    );

    test('get changes email', () async {
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
              "Email/changes",
              {
                "accountId": "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                "oldState": "57c15230-2588-11ec-a759-2fef1ee78d9e",
                "newState": "561dc870-2595-11ec-a759-2fef1ee78d9e",
                "hasMoreChanges": false,
                "created": [
                  "a59d5ca0-258e-11ec-a759-2fef1ee78d9e",
                  "54fa3000-2595-11ec-a759-2fef1ee78d9e"
                ],
                "updated": [
                  "a59d5ca0-258e-11ec-a759-2fef1ee78d9e"
                ],
                "destroyed": []
              },
              "c1"
            ],
            [
              "Email/get",
              {
                "accountId": "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                "notFound": [],
                "state": "561dc870-2595-11ec-a759-2fef1ee78d9e",
                "list": [
                  {
                    "keywords": {
                      "\$seen": true
                    },
                    "mailboxIds": {
                      "aba7e8d0-18d9-11eb-a677-2990b970028d": true
                    },
                    "id": "a59d5ca0-258e-11ec-a759-2fef1ee78d9e"
                  }
                ]
              },
              "c2"
            ],
            [
              "Email/get",
              {
                "accountId": "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                "notFound": [],
                "state": "561dc870-2595-11ec-a759-2fef1ee78d9e",
                "list": [
                  {
                    "preview": "This event is about to begin test TimeTuesday 29 September 2020 06:00 - 06:30 Europe/Paris (See in Calendar)Location1 thai ha (See in Map)Attendees - User A <usera@qa.open-paas.org> (Organizer) -  <userb@qa.open-paas.org> Resourcesnew directoryNotesaaaa *#",
                    "hasAttachment": false,
                    "size": 24946,
                    "keywords": {
                      "\$seen": true
                    },
                    "subject": "Notification: test",
                    "from": [
                      {
                        "email": "noreply@qa.open-paas.org"
                      }
                    ],
                    "sentAt": "2021-10-05T03:45:01Z",
                    "id": "a59d5ca0-258e-11ec-a759-2fef1ee78d9e",
                    "to": [
                      {
                        "email": "userb@qa.open-paas.org"
                      }
                    ],
                    "receivedAt": "2021-10-05T03:45:13Z"
                  },
                  {
                    "preview": "This event is about to begin A - show datetime1 TimeTuesday 15 September 2020 07:03 - 07:33 Europe/Paris (See in Calendar)Location1 thai ha1 (See in Map)Attendees - User A <usera@qa.open-paas.org> (Organizer) - Thanh Loan LE <tlle@linagora.com> - User C <u",
                    "hasAttachment": false,
                    "size": 24857,
                    "keywords": {},
                    "subject": "Notification: A - show datetime1",
                    "from": [
                      {
                        "email": "noreply@qa.open-paas.org"
                      }
                    ],
                    "sentAt": "2021-10-05T04:33:01Z",
                    "id": "54fa3000-2595-11ec-a759-2fef1ee78d9e",
                    "to": [
                      {
                        "email": "userb@qa.open-paas.org"
                      }
                    ],
                    "receivedAt": "2021-10-05T04:33:04Z"
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
              "Email/changes",
              {
                "accountId": "93c56f4408cff66f0a929aea8e3940e753c3275e5622582ae3010e7277b7696c",
                "sinceState": "57c15230-2588-11ec-a759-2fef1ee78d9e"
              },
              "c1"
            ],
            [
              "Email/get",
              {
                "accountId": "93c56f4408cff66f0a929aea8e3940e753c3275e5622582ae3010e7277b7696c",
                "#ids": {
                  "resultOf": "c1",
                  "name": "Email/changes",
                  "path": "/updated"
                },
                "properties": [
                  "mailboxIds",
                  "keywords"
                ]
              },
              "c2"
            ],
            [
              "Email/get",
              {
                "accountId": "93c56f4408cff66f0a929aea8e3940e753c3275e5622582ae3010e7277b7696c",
                "#ids": {
                  "resultOf": "c1",
                  "name": "Email/changes",
                  "path": "/created"
                },
                "properties": [
                  "id",
                  "subject",
                  "from",
                  "to",
                  "cc",
                  "bcc",
                  "keywords",
                  "size",
                  "receivedAt",
                  "sentAt",
                  "replyTo",
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
          "content-length": 1733
        }
      );

      final HttpClient httpClient = HttpClient(dio);
      final processingInvocation = ProcessingInvocation();
      final jmapRequestBuilder = JmapRequestBuilder(httpClient, processingInvocation);
      final accountId = AccountId(Id('93c56f4408cff66f0a929aea8e3940e753c3275e5622582ae3010e7277b7696c'));
      final state = State('57c15230-2588-11ec-a759-2fef1ee78d9e');

      final changesEmailMethod = ChangesEmailMethod(accountId, state);
      final changesEmailInvocation = jmapRequestBuilder.invocation(changesEmailMethod, methodCallId: MethodCallId('c1'));

      final getEmailMethodForUpdate = GetEmailMethod(accountId)
        ..addProperties(Properties({'mailboxIds', 'keywords'}))
        ..addReferenceIds(processingInvocation.createResultReference(changesEmailInvocation.methodCallId, ReferencePath('/updated')));
      final getEmailForUpdateInvocation = jmapRequestBuilder.invocation(getEmailMethodForUpdate, methodCallId: MethodCallId('c2'));
      
      final getEmailMethodForCreated = GetEmailMethod(accountId)
        ..addProperties(Properties({
          'id',
          'subject',
          'from',
          'to',
          'cc',
          'bcc',
          'keywords',
          'size',
          'receivedAt',
          'sentAt',
          'replyTo',
          'preview',
          'hasAttachment'}))
        ..addReferenceIds(processingInvocation.createResultReference(changesEmailInvocation.methodCallId, ReferencePath('/created')));
      final getEmailForCreatedInvocation = jmapRequestBuilder.invocation(getEmailMethodForCreated, methodCallId: MethodCallId('c3'));

      final result = await (jmapRequestBuilder
          ..usings(getEmailMethodForUpdate.requiredCapabilities))
        .build()
        .execute();

      final resultUpdated = result.parse<GetEmailResponse>(
          getEmailForUpdateInvocation.methodCallId,
          GetEmailResponse.deserialize);

      final resultCreated = result.parse<GetEmailResponse>(
          getEmailForCreatedInvocation.methodCallId,
          GetEmailResponse.deserialize);

      expect(resultUpdated!.list[0], equals(expectMail1));
      expect(resultCreated!.list[0], equals(expectMail2));
      expect(resultCreated.list[1], equals(expectMail3));
    });
  });
}