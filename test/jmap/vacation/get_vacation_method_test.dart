import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/utc_date.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/vacation/get/get_vacation_method.dart';
import 'package:jmap_dart_client/jmap/mail/vacation/get/get_vacation_response.dart';
import 'package:jmap_dart_client/jmap/mail/vacation/vacation_id.dart';
import 'package:jmap_dart_client/jmap/mail/vacation/vacation_response.dart';

void main() {
  group('test to json get vacation method', () {
    final expectVacation = VacationResponse(
        id: VacationId.singleton(),
        isEnabled: true,
        fromDate: UTCDate(DateTime.parse('2022-08-16T15:00:00.000Z'))
    );

    test('get vacation method and response parsing', () async {
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
                "VacationResponse/get",
                {
                  "accountId": "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555",
                  "notFound": [],
                  "state": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                  "list": [
                    {
                      "id": "singleton",
                      "isEnabled": true,
                      "fromDate": "2022-08-16T15:00:00.000Z"
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
              "urn:ietf:params:jmap:vacationresponse"
            ],
            "methodCalls": [
              [
                "VacationResponse/get",
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
            "content-length": 206
          }
      );

      final httpClient = HttpClient(dio);
      final processingInvocation = ProcessingInvocation();
      final accountId = AccountId(Id('0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555'));

      final getVacationMethod = GetVacationMethod(accountId);

      final requestBuilder = JmapRequestBuilder(httpClient, processingInvocation);
      final getVacationInvocation = requestBuilder.invocation(getVacationMethod);
      final response = await (requestBuilder
            ..usings(getVacationMethod.requiredCapabilities))
          .build()
          .execute();

      final resultList = response.parse<GetVacationResponse>(
          getVacationInvocation.methodCallId,
          GetVacationResponse.deserialize);

      expect(resultList?.list.length, equals(1));
      expect(resultList?.list, contains(expectVacation));
    });
  });
}