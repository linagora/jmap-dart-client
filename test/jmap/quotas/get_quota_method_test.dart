import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/quotas/data_types.dart';
import 'package:jmap_dart_client/jmap/quotas/get/get_quota_method.dart';
import 'package:jmap_dart_client/jmap/quotas/get/get_quota_response.dart';
import 'package:jmap_dart_client/jmap/quotas/quota.dart';

void main() {
  group('test to json get quota method', () {
    final expectQuota1 = Quota(
      Id('382312d0-fa5c-11eb-b647-2fef1ee78d9e'),
      ResourceType.count,
      UnsignedInt(20000),
      UnsignedInt(50000),
      Scope.account,
      'tdvu@example.com',
      [DataType.mail]
    );

    final expectQuota2 = Quota(
      Id('382312d0-fa5c-11eb-b647-2fef1ee876hd'),
      ResourceType.count,
      UnsignedInt(10000),
      UnsignedInt(70000),
      Scope.account,
      'datvu@example.com',
      [DataType.mail, DataType.calendar, DataType.contact],
      description: 'Personal account usage',
      softLimit: UnsignedInt(30000),
      warnLimit: UnsignedInt(12000)
    );

    test('get quota method and response parsing', () async {
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
              "Quota/get",
              {
                "accountId": "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555",
                "notFound": [],
                "state": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                "list": [
                  {
                    "id": "382312d0-fa5c-11eb-b647-2fef1ee78d9e",
                    "resourceType": "count",
                    "used": 20000,
                    "limit": 50000,
                    "scope": "account",
                    "name": "tdvu@example.com",
                    "dataTypes" : ["Mail"]
                  },
                  {
                    "id": "382312d0-fa5c-11eb-b647-2fef1ee876hd",
                    "resourceType": "count",
                    "used": 10000,
                    "warnLimit": 12000,
                    "softLimit": 30000,
                    "limit": 70000,
                    "scope": "account",
                    "name": "datvu@example.com",
                    "description": "Personal account usage",
                    "dataTypes" : ["Mail", "Calendar", "Contact"]
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
            "urn:ietf:params:jmap:quota"
          ],
          "methodCalls": [
            [
              "Quota/get",
              {
                "accountId": "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555"
              },
              "c0"
            ]
          ]
        },
        headers: {
          "accept": "application/json;jmapVersion=rfc-8621",
          "content-type": "application/json; charset=utf-8",
          "content-length": 212
        }
      );

      final httpClient = HttpClient(dio);
      final processingInvocation = ProcessingInvocation();
      final accountId = AccountId(Id('0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555'));
      final getQuotaMethod = GetQuotaMethod(accountId);
      final requestBuilder = JmapRequestBuilder(httpClient, processingInvocation);
      final getQuotaInvocation = requestBuilder.invocation(getQuotaMethod);
      final response = await (requestBuilder
          ..usings(getQuotaMethod.requiredCapabilities))
        .build()
        .execute();

      final resultList = response.parse<GetQuotaResponse>(
        getQuotaInvocation.methodCallId,
        GetQuotaResponse.deserialize);

      expect(resultList?.list.length, equals(2));
      expect(resultList?.list, containsAll([expectQuota1, expectQuota2]));
    });
  });
}