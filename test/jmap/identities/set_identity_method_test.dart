import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/identities/identity.dart';
import 'package:jmap_dart_client/jmap/identities/set/set_identity_method.dart';
import 'package:jmap_dart_client/jmap/identities/set/set_identity_response.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';

void main() {
  group('test to json set identity method', () {
    final expectedCreated = Identity(
      id: IdentityId(Id('bc6d7c78-672a-45e9-b0de-1dfd2699020a')),
    );

    test('set identity method and response parsing', () async {
      final baseOption = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onPost(
          '',
          (server) => server.reply(200, {
                "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                "methodResponses": [
                  [
                    "Identity/set",
                    {
                      "accountId":
                          "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                      "newState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                      "created": {
                        "dab246": {
                          "id": "bc6d7c78-672a-45e9-b0de-1dfd2699020a",
                          "mayDelete": true
                        }
                      }
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
                "Identity/set",
                {
                  "accountId":
                      "3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12",
                  "create": {
                    "dab246": {
                      "name": "User B1",
                      "email": "userb@qa.open-paas.org",
                      "textSignature": "",
                      "htmlSignature":
                          "<body><div>Dat T. Vu <br>Mobile Engineer <br>LINAGORA VIETNAM <br>A: 8th Floor (Toong VPBank Tower, No. 5 Dien Bien Phu  Str., Ba Dinh Dist., Ha Noi <br>P: (+84) 366-769-439<br>E: tdvu@linagora.com</div></body>"
                    }
                  }
                },
                "c0"
              ]
            ]
          },
          headers: {
            "accept": "application/json;jmapVersion=rfc-8621",
            "content-length": 813
          });

      final setIdentityMethod = SetIdentityMethod(AccountId(Id(
          '3ce33c876a726662c627746eb9537a1d13c2338193ef27bd051a3ce5c0fe5b12')))
        ..addCreate(
            Id('dab246'),
            Identity(
                name: 'User B1',
                email: 'userb@qa.open-paas.org',
                textSignature: Signature(''),
                htmlSignature: Signature(
                    '<body><div>Dat T. Vu <br>Mobile Engineer <br>LINAGORA VIETNAM <br>A: 8th Floor (Toong VPBank Tower, No. 5 Dien Bien Phu  Str., Ba Dinh Dist., Ha Noi <br>P: (+84) 366-769-439<br>E: tdvu@linagora.com</div></body>')));

      final httpClient = HttpClient(dio);
      final requestBuilder =
          JmapRequestBuilder(httpClient, ProcessingInvocation());
      final setIdentityInvocation =
          requestBuilder.invocation(setIdentityMethod);
      final response = await (requestBuilder
            ..usings(setIdentityMethod.requiredCapabilities))
          .build()
          .execute();

      final setIdentityResponse = response.parse<SetIdentityResponse>(
          setIdentityInvocation.methodCallId, SetIdentityResponse.deserialize);

      expect(setIdentityResponse!.created![Id('dab246')]!.id,
          equals(expectedCreated.id));
    });
  });
}
