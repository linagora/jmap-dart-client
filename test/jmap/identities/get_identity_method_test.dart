import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/identities/get/get_identity_method.dart';
import 'package:jmap_dart_client/jmap/identities/get/get_identity_response.dart';
import 'package:jmap_dart_client/jmap/identities/identity.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_address.dart';

void main() {
  group('test to json get identity method', () {
    final expectIdentity1 = Identity(
        id: IdentityId(Id('6f15f98e-375f-3634-aae6-903e9356c196')),
        name: 'userb@qa.open-paas.org',
        email: 'userb@qa.open-paas.org',
        bcc: {EmailAddress('user b', 'userb@qa.open-paas.org')},
        textSignature: Signature(''),
        htmlSignature: Signature(''),
        mayDelete: false
    );

    final expectIdentity2 = Identity(
        id: IdentityId(Id('903e9356c196-6f15f98e-375f-3634-aae6')),
        name: 'usera@qa.open-paas.org',
        email: 'usera@qa.open-paas.org',
        textSignature: Signature('User A'),
        htmlSignature: Signature('<p>User A</p>'),
        mayDelete: true
    );

    test('get identity method and response parsing', () async {
      final baseOption  = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)
        ..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
      dioAdapter.onPost('', (server) => server.reply(200, {
            "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
            "methodResponses": [
              [
                "Identity/get",
                {
                  "accountId": "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                  "state": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                  "list": [
                    {
                      "id": "6f15f98e-375f-3634-aae6-903e9356c196",
                      "name": "userb@qa.open-paas.org",
                      "email": "userb@qa.open-paas.org",
                      "bcc": [
                        {
                          "name": "user b",
                          "email": "userb@qa.open-paas.org"
                        }
                      ],
                      "textSignature": "",
                      "htmlSignature": "",
                      "mayDelete": false
                    },
                    {
                      "id": "903e9356c196-6f15f98e-375f-3634-aae6",
                      "name": "usera@qa.open-paas.org",
                      "email": "usera@qa.open-paas.org",
                      "textSignature": "User A",
                      "htmlSignature": "<p>User A</p>",
                      "mayDelete": true
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
              "urn:ietf:params:jmap:submission"
            ],
            "methodCalls": [
              [
                "Identity/get",
                {
                  "accountId": "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12"
                },
                "c0"
              ]
            ]
          },
          headers: {
            "accept": "application/json;jmapVersion=rfc-8621",
            "content-length": 247
          }
      );

      final httpClient = HttpClient(dio);
      final processingInvocation = ProcessingInvocation();
      final requestBuilder = JmapRequestBuilder(httpClient, processingInvocation);
      final accountId = AccountId(Id('3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12'));

      final getIdentityMethod = GetIdentityMethod(accountId);
      final getIdentityInvocation = requestBuilder.invocation(getIdentityMethod);
      final response = await (requestBuilder
            ..usings(getIdentityMethod.requiredCapabilities))
          .build()
          .execute();

      final resultList = response.parse<GetIdentityResponse>(
          getIdentityInvocation.methodCallId,
          GetIdentityResponse.deserialize);

      expect(resultList?.list.length, equals(2));
      expect(resultList?.list, containsAll({expectIdentity1, expectIdentity2}));
    });
  });
}