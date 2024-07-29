import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/utc_date.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/vacation/get/get_vacation_method.dart';
import 'package:jmap_dart_client/jmap/mail/vacation/get/get_vacation_response.dart';
import 'package:jmap_dart_client/jmap/mail/vacation/set/set_vacation_method.dart';
import 'package:jmap_dart_client/jmap/mail/vacation/vacation_id.dart';
import 'package:jmap_dart_client/jmap/mail/vacation/vacation_response.dart';

void main() {
  group('test to json set vacation method', () {
    final expectedUpdated = VacationResponse(
        id: VacationId.singleton(),
        isEnabled: true,
        fromDate: UTCDate(DateTime.parse('2022-08-16T15:00:00.000Z')),
        textBody: 'Hello dab');

    test('set vacation method and response parsing', () async {
      final baseOption = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onPost(
          '',
          (server) => server.reply(200, {
                "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                "methodResponses": [
                  [
                    "VacationResponse/set",
                    {
                      "accountId":
                          "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555",
                      "newState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                      "updated": {"singleton": {}}
                    },
                    "c0"
                  ],
                  [
                    "VacationResponse/get",
                    {
                      "accountId":
                          "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555",
                      "notFound": [],
                      "state": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                      "list": [
                        {
                          "id": "singleton",
                          "isEnabled": true,
                          "fromDate": "2022-08-16T15:00:00.000Z",
                          "textBody": "Hello dab"
                        }
                      ]
                    },
                    "c1"
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
                "VacationResponse/set",
                {
                  "accountId":
                      "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555",
                  "update": {
                    "singleton": {
                      "isEnabled": true,
                      "fromDate": "2022-08-16T15:00:00.000Z",
                      "toDate": null,
                      "subject": null,
                      "textBody": "Hello dab",
                      "htmlBody": null
                    }
                  }
                },
                "c0"
              ],
              [
                "VacationResponse/get",
                {
                  "accountId":
                      "0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555"
                },
                "c1"
              ]
            ]
          },
          headers: {
            "accept": "application/json;jmapVersion=rfc-8621",
            "content-length": 875
          });

      final accountId = AccountId(Id(
          '0d14dbabe6482aff5cbf922e04cef51a40b4eabccbe12d28fe27c97038752555'));
      final httpClient = HttpClient(dio);
      final processingInvocation = ProcessingInvocation();

      final setVacationMethod = SetVacationMethod(accountId)
        ..addUpdatesSingleton({
          VacationId.singleton().id: VacationResponse(
              isEnabled: true,
              fromDate: UTCDate(DateTime.parse('2022-08-16T15:00:00.000Z')),
              textBody: 'Hello dab')
        });

      final requestBuilder =
          JmapRequestBuilder(httpClient, processingInvocation)
            ..invocation(setVacationMethod);

      final getVacationMethod = GetVacationMethod(accountId);
      final getVacationInvocation =
          requestBuilder.invocation(getVacationMethod);

      final response = await (requestBuilder
            ..usings(setVacationMethod.requiredCapabilities))
          .build()
          .execute();

      final getVacationResponse = response.parse<GetVacationResponse>(
          getVacationInvocation.methodCallId, GetVacationResponse.deserialize);

      expect(getVacationResponse!.list, contains(expectedUpdated));
    });
  });
}
