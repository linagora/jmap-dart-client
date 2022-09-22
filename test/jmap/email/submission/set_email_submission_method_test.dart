import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:jmap_dart_client/http/converter/mailbox_id_converter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/jmap/core/reference_id.dart';
import 'package:jmap_dart_client/jmap/core/reference_prefix.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_address.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_body_part.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_body_value.dart';
import 'package:jmap_dart_client/jmap/mail/email/individual_header_identifier.dart';
import 'package:jmap_dart_client/jmap/mail/email/set/set_email_method.dart';
import 'package:jmap_dart_client/jmap/mail/email/set/set_email_response.dart';
import 'package:jmap_dart_client/jmap/mail/email/submission/address.dart';
import 'package:jmap_dart_client/jmap/mail/email/submission/email_submission.dart';
import 'package:jmap_dart_client/jmap/mail/email/submission/email_submission_id.dart';
import 'package:jmap_dart_client/jmap/mail/email/submission/envelope.dart';
import 'package:jmap_dart_client/jmap/mail/email/submission/set/set_email_submission_method.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';

void main() {
  group('test to json set email submission method', () {
    final expectedCreated = Email(
        EmailId(Id('64469f10-8e15-11ec-984e-e3f8b83572b4')),
        blobId: Id('64469f10-8e15-11ec-984e-e3f8b83572b4'),
        threadId: ThreadId(Id('64469f10-8e15-11ec-984e-e3f8b83572b4')),
        size: UnsignedInt(742)
    );

    test('set email submission method and response parsing', () async {
      final baseOption = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onPost(
          '',
          (server) => server.reply(200, {
            "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
            "methodResponses": [
              [
                "Email/set",
                {
                  "accountId": "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                  "oldState": "3534e880-8e15-11ec-984e-e3f8b83572b4",
                  "newState": "64b98520-8e15-11ec-984e-e3f8b83572b4",
                  "created": {
                    "dab1234": {
                      "id": "64469f10-8e15-11ec-984e-e3f8b83572b4",
                      "blobId": "64469f10-8e15-11ec-984e-e3f8b83572b4",
                      "threadId": "64469f10-8e15-11ec-984e-e3f8b83572b4",
                      "size": 742
                    }
                  }
                },
                "c0"
              ],
              [
                "EmailSubmission/set",
                {
                  "accountId": "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                  "newState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                  "created": {
                    "a1234": "6a4cf0b9-956e-41d5-9122-4824e3ea9baf"
                  }
                },
                "c1"
              ],
              [
                "Email/set",
                {
                  "accountId": "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                  "oldState": "64b98520-8e15-11ec-984e-e3f8b83572b4",
                  "newState": "64b98520-8e15-11ec-984e-e3f8b83572b4",
                  "updated": {
                    "64469f10-8e15-11ec-984e-e3f8b83572b4": null
                  }
                },
                "c1"
              ]
            ]
          }),
          data: {
            "using": [
              "urn:ietf:params:jmap:submission",
              "urn:ietf:params:jmap:mail",
              "urn:ietf:params:jmap:core"
            ],
            "methodCalls": [
              [
                "Email/set",
                {
                  "accountId": "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                  "create": {
                    "dab1234": {
                      "id": "dab1234",
                      "mailboxIds": {
                        "5dfb3290-0a14-11ec-b57c-2fef1ee78d9e": true
                      },
                      "subject": "test send email",
                      "from": [
                        {
                          "name": "userB",
                          "email": "userb@qa.open-paas.org"
                        }
                      ],
                      "to": [
                        {
                          "name": "userD",
                          "email": "userd@qa.open-paas.org"
                        }
                      ],
                      "htmlBody": [
                        {"partId": "mmm", "blobId": "aaaa", "type": "text/html"}
                      ],
                      "bodyValues": {
                        "mmm": {
                          "value": "<!DOCTYPE html> <html> <body> <p><b>Hello test send 2</b></p><br><br></body> </html>",
                          "isEncodingProblem": false,
                          "isTruncated": false
                        }
                      }
                    }
                  }
                },
                "c0"
              ],
              [
                "EmailSubmission/set",
                {
                  "accountId": "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                  "create": {
                    "a1234": {
                      "emailId": "#dab1234",
                      "envelope": {
                        "mailFrom": {"email": "userb@qa.open-paas.org"},
                        "rcptTo": [
                          {"email": "userd@qa.open-paas.org"}
                        ]
                      }
                    }
                  },
                  "onSuccessUpdateEmail": {
                    "#a1234": {
                      "mailboxIds": {
                        "5dfb3290-0a14-11ec-b57c-2fef1ee78d9e": true
                      }
                    }
                  }
                },
                "c1"
              ]
            ]
          },
          headers: {
            "accept": "application/json;jmapVersion=rfc-8621",
            "content-type": "application/json; charset=utf-8",
            "content-length": 1039
          });

      final setEmailMethod = SetEmailMethod(AccountId(Id('3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12')))
        ..addCreate(Id('dab1234'),
            Email(
              EmailId(Id('dab1234')),
              mailboxIds: {MailboxId(Id('5dfb3290-0a14-11ec-b57c-2fef1ee78d9e')): true},
              subject: 'test send email',
              from: {EmailAddress("userB", 'userb@qa.open-paas.org')},
              to: {EmailAddress("userD", 'userd@qa.open-paas.org')},
              htmlBody: {EmailBodyPart(partId: PartId('mmm'), blobId: Id('aaaa'), type: MediaType.parse('text/html'))},
              bodyValues: {
                PartId('mmm'): EmailBodyValue('<!DOCTYPE html> <html> <body> <p><b>Hello test send 2</b></p><br><br></body> </html>', false, false)
              }
            )
        );

      final setEmailSubmissionMethod = SetEmailSubmissionMethod(AccountId(Id('3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12')))
        ..addCreate(
            Id('a1234'),
            EmailSubmission(
                emailId: EmailId(ReferenceId(ReferencePrefix.defaultPrefix, Id('dab1234'))),
                envelope: Envelope(
                    Address('userb@qa.open-paas.org'),
                    {Address('userd@qa.open-paas.org')})))
        ..addOnSuccessUpdateEmail({
          EmailSubmissionId(ReferenceId(ReferencePrefix.defaultPrefix, Id('a1234'))): PatchObject({
            PatchObject.mailboxIdsProperty: {
              MailboxIdConverter().toJson(MailboxId(Id('5dfb3290-0a14-11ec-b57c-2fef1ee78d9e'))): true
            }
          })
        });

      final httpClient = HttpClient(dio);
      final requestBuilder =
          JmapRequestBuilder(httpClient, ProcessingInvocation());

      final setEmailInvocation = requestBuilder.invocation(setEmailMethod);

      final setEmailSubmissionInvocation = requestBuilder.invocation(setEmailSubmissionMethod);

      final response = await (requestBuilder
            ..usings(setEmailSubmissionMethod.requiredCapabilities))
          .build()
          .execute();

      final setEmailResponse = response.parse<SetEmailResponse>(
          setEmailInvocation.methodCallId,
          SetEmailResponse.deserialize);

      final setEmailUpdateResponse = response.parse<SetEmailResponse>(
          setEmailSubmissionInvocation.methodCallId,
          SetEmailResponse.deserialize,
          methodName: setEmailInvocation.methodName);

      expect(setEmailResponse?.created?[Id('dab1234')],
          equals(expectedCreated));

      expect(setEmailUpdateResponse?.updated?[Id('64469f10-8e15-11ec-984e-e3f8b83572b4')],
          equals(null));
    });

    test('set email submission method and response parsing with header User-Agent', () async {
      final baseOption = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onPost(
          '',
              (server) => server.reply(200, {
                "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                "methodResponses": [
                  [
                    "Email/set",
                    {
                      "accountId": "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                      "oldState": "3534e880-8e15-11ec-984e-e3f8b83572b4",
                      "newState": "64b98520-8e15-11ec-984e-e3f8b83572b4",
                      "created": {
                        "dab1234": {
                          "id": "64469f10-8e15-11ec-984e-e3f8b83572b4",
                          "blobId": "64469f10-8e15-11ec-984e-e3f8b83572b4",
                          "threadId": "64469f10-8e15-11ec-984e-e3f8b83572b4",
                          "size": 742
                        }
                      }
                    },
                    "c0"
                  ],
                  [
                    "EmailSubmission/set",
                    {
                      "accountId": "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                      "newState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                      "created": {
                        "a1234": "6a4cf0b9-956e-41d5-9122-4824e3ea9baf"
                      }
                    },
                    "c1"
                  ],
                  [
                    "Email/set",
                    {
                      "accountId": "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                      "oldState": "64b98520-8e15-11ec-984e-e3f8b83572b4",
                      "newState": "64b98520-8e15-11ec-984e-e3f8b83572b4",
                      "updated": {
                        "64469f10-8e15-11ec-984e-e3f8b83572b4": null
                      }
                    },
                    "c1"
                  ]
                ]
              }),
          data: {
            "using": [
              "urn:ietf:params:jmap:submission",
              "urn:ietf:params:jmap:mail",
              "urn:ietf:params:jmap:core"
            ],
            "methodCalls": [
              [
                "Email/set",
                {
                  "accountId": "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                  "create": {
                    "dab1234": {
                      "id": "dab1234",
                      "mailboxIds": {
                        "5dfb3290-0a14-11ec-b57c-2fef1ee78d9e": true
                      },
                      "subject": "test send email",
                      "from": [
                        {
                          "name": "userB",
                          "email": "userb@qa.open-paas.org"
                        }
                      ],
                      "to": [
                        {
                          "name": "userD",
                          "email": "userd@qa.open-paas.org"
                        }
                      ],
                      "htmlBody": [
                        {"partId": "mmm", "blobId": "aaaa", "type": "text/html"}
                      ],
                      "bodyValues": {
                        "mmm": {
                          "value": "<!DOCTYPE html> <html> <body> <p><b>Hello test send 2</b></p><br><br></body> </html>",
                          "isEncodingProblem": false,
                          "isTruncated": false
                        }
                      },
                      "header:User-Agent:asText": "Android/1.0.0 TeamMail/1.0"
                    }
                  }
                },
                "c0"
              ],
              [
                "EmailSubmission/set",
                {
                  "accountId": "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                  "create": {
                    "a1234": {
                      "emailId": "#dab1234",
                      "envelope": {
                        "mailFrom": {"email": "userb@qa.open-paas.org"},
                        "rcptTo": [
                          {"email": "userd@qa.open-paas.org"}
                        ]
                      }
                    }
                  },
                  "onSuccessUpdateEmail": {
                    "#a1234": {
                      "mailboxIds": {
                        "5dfb3290-0a14-11ec-b57c-2fef1ee78d9e": true
                      }
                    }
                  }
                },
                "c1"
              ]
            ]
          },
          headers: {
            "accept": "application/json;jmapVersion=rfc-8621",
            "content-type": "application/json; charset=utf-8",
            "content-length": 1095
          });

      final setEmailMethod = SetEmailMethod(AccountId(Id('3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12')))
        ..addCreate(Id('dab1234'),
            Email(
                EmailId(Id('dab1234')),
                mailboxIds: {MailboxId(Id('5dfb3290-0a14-11ec-b57c-2fef1ee78d9e')): true},
                subject: 'test send email',
                from: {EmailAddress("userB", 'userb@qa.open-paas.org')},
                to: {EmailAddress("userD", 'userd@qa.open-paas.org')},
                htmlBody: {EmailBodyPart(partId: PartId('mmm'), blobId: Id('aaaa'), type: MediaType.parse('text/html'))},
                bodyValues: {
                  PartId('mmm'): EmailBodyValue('<!DOCTYPE html> <html> <body> <p><b>Hello test send 2</b></p><br><br></body> </html>', false, false)
                },
                headerUserAgent: {IndividualHeaderIdentifier.headerUserAgent : 'Android/1.0.0 TeamMail/1.0'}
            )
        );

      final setEmailSubmissionMethod = SetEmailSubmissionMethod(AccountId(Id('3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12')))
        ..addCreate(
            Id('a1234'),
            EmailSubmission(
                emailId: EmailId(ReferenceId(ReferencePrefix.defaultPrefix, Id('dab1234'))),
                envelope: Envelope(
                    Address('userb@qa.open-paas.org'),
                    {Address('userd@qa.open-paas.org')})))
        ..addOnSuccessUpdateEmail({
          EmailSubmissionId(ReferenceId(ReferencePrefix.defaultPrefix, Id('a1234'))): PatchObject({
            PatchObject.mailboxIdsProperty: {
              MailboxIdConverter().toJson(MailboxId(Id('5dfb3290-0a14-11ec-b57c-2fef1ee78d9e'))): true
            }
          })
        });

      final httpClient = HttpClient(dio);
      final requestBuilder =
      JmapRequestBuilder(httpClient, ProcessingInvocation());

      final setEmailInvocation = requestBuilder.invocation(setEmailMethod);

      final setEmailSubmissionInvocation = requestBuilder.invocation(setEmailSubmissionMethod);

      final response = await (requestBuilder
        ..usings(setEmailSubmissionMethod.requiredCapabilities))
          .build()
          .execute();

      final setEmailResponse = response.parse<SetEmailResponse>(
          setEmailInvocation.methodCallId,
          SetEmailResponse.deserialize);

      final setEmailUpdateResponse = response.parse<SetEmailResponse>(
          setEmailSubmissionInvocation.methodCallId,
          SetEmailResponse.deserialize,
          methodName: setEmailInvocation.methodName);

      expect(setEmailResponse?.created?[Id('dab1234')],
          equals(expectedCreated));

      expect(setEmailUpdateResponse?.updated?[Id('64469f10-8e15-11ec-984e-e3f8b83572b4')],
          equals(null));
    });
  });
}
