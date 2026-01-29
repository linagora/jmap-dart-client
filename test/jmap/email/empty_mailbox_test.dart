import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/request/reference_path.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_comparator.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_comparator_property.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_filter_condition.dart';
import 'package:jmap_dart_client/jmap/mail/email/query/query_email_method.dart';
import 'package:jmap_dart_client/jmap/mail/email/query/query_email_response.dart';
import 'package:jmap_dart_client/jmap/mail/email/set/set_email_method.dart';
import 'package:jmap_dart_client/jmap/mail/email/set/set_email_response.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';

void main() {
  group('empty trash folder', () {
    test('base on Email/query + Email/set', () async {
      final baseOption  = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)
        ..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onPost(
        '',
        (server) => server.reply(200, {
          'sessionState': '2c9f1b12-b35a-43e6-9af2-0106fb53a943',
          'methodResponses': [
            [
              'Email/query',
              {
                'accountId': '871ae8d53c475bffcd0530c2c673a18862a6ab967b1ac1f78c581fd150eb4120',
                'queryState': '9b4f0a48',
                'canCalculateChanges': false,
                'ids': [
                  'c141aff0-a665-11ef-8719-49ce43e9b8e8',
                  '3b4d65e0-a58b-11ef-8719-49ce43e9b8e8',
                  'c927f050-a0b4-11ef-b19d-250264ebca76',
                  '97794bf0-a0ad-11ef-b19d-250264ebca76',
                  '7fa6d100-a0ad-11ef-b19d-250264ebca76',
                  '1729c0c0-9b61-11ef-bb9d-71e3f2afce5e',
                  'cf039960-9b60-11ef-bb9d-71e3f2afce5e',
                  '87531730-9b60-11ef-bb9d-71e3f2afce5e'
                ],
                'position': 0,
                'limit': 256
              },
              'c0'
            ],
            [
              'Email/set',
              {
                'accountId': '871ae8d53c475bffcd0530c2c673a18862a6ab967b1ac1f78c581fd150eb4120',
                'oldState': 'a1f36a90-c3a1-11ef-8bac-4d07695fed6f',
                'newState': 'a1f36a90-c3a1-11ef-8bac-4d07695fed6f',
                'destroyed': [
                  'c141aff0-a665-11ef-8719-49ce43e9b8e8',
                  '3b4d65e0-a58b-11ef-8719-49ce43e9b8e8',
                  'c927f050-a0b4-11ef-b19d-250264ebca76',
                  '97794bf0-a0ad-11ef-b19d-250264ebca76',
                  '7fa6d100-a0ad-11ef-b19d-250264ebca76',
                  '1729c0c0-9b61-11ef-bb9d-71e3f2afce5e',
                  'cf039960-9b60-11ef-bb9d-71e3f2afce5e',
                  '87531730-9b60-11ef-bb9d-71e3f2afce5e'
                ]
              },
              'c1'
            ]
          ]
        }),
        data: {
          "methodCalls": [
            [
              "Email/query",
              {
                "accountId": "871ae8d53c475bffcd0530c2c673a18862a6ab967b1ac1f78c581fd150eb4120",
                "filter": {
                  "inMailbox": "025b0580-6422-11ef-a702-5d10e1ebf1c3"
                },
                "sort": [
                  {
                    "isAscending": false,
                    "property": "receivedAt"
                  }
                ]
              },
              "c0"
            ],
            [
              "Email/set",
              {
                "accountId": "871ae8d53c475bffcd0530c2c673a18862a6ab967b1ac1f78c581fd150eb4120",
                "#destroy": {
                  "resultOf": "c0",
                  "name": "Email/query",
                  "path": "/ids/*"
                }
              },
              "c1"
            ]
          ],
          "using": [
            "urn:ietf:params:jmap:core",
            "urn:ietf:params:jmap:mail"
          ],
        },
        headers: {
          "accept": "application/json;jmapVersion=rfc-8621",
          "content-length": 813,
        }
      );

      final httpClient = HttpClient(dio);
      final processingInvocation = ProcessingInvocation();
      final jmapRequestBuilder = JmapRequestBuilder(httpClient, processingInvocation);
      final accountId = AccountId(Id('871ae8d53c475bffcd0530c2c673a18862a6ab967b1ac1f78c581fd150eb4120'));

      final queryEmailMethod = QueryEmailMethod(accountId)
        ..addSorts({EmailComparator(EmailComparatorProperty.receivedAt)..setIsAscending(false)})
        ..addFilters(EmailFilterCondition(inMailbox: MailboxId((Id('025b0580-6422-11ef-a702-5d10e1ebf1c3')))));
      final queryEmailInvocation = jmapRequestBuilder.invocation(queryEmailMethod, methodCallId: MethodCallId('c0'));

      final setEmailMethod = SetEmailMethod(accountId)
        ..addReferenceDestroy(
            processingInvocation.createResultReference(
              queryEmailInvocation.methodCallId,
              ReferencePath.idsPath,
            )
        );
      final setEmailInvocation = jmapRequestBuilder.invocation(
        setEmailMethod,
        methodCallId: MethodCallId('c1')
      );

      final result = await (jmapRequestBuilder
        ..usings({CapabilityIdentifier.jmapCore, CapabilityIdentifier.jmapMail}))
          .build()
          .execute();

      final resulQuery = result.parse<QueryEmailResponse>(
        queryEmailInvocation.methodCallId,
        QueryEmailResponse.deserialize
      );
      expect(resulQuery!.canCalculateChanges, isFalse);
      expect(resulQuery.ids, hasLength(8));

      final resultSet = result.parse<SetEmailResponse>(
        setEmailInvocation.methodCallId,
        SetEmailResponse.deserialize
      );
      expect(resultSet!.destroyed, hasLength(8));
      expect(resultSet.destroyed, containsAll(resulQuery.ids));
    });
  });
}