import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/properties/properties.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/identities/get/get_identity_method.dart';
import 'package:jmap_dart_client/jmap/identities/get/get_identity_response.dart';
import 'package:jmap_dart_client/jmap/identities/identity.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/email/email_address.dart';

void main() {
  group('test to json get identity method', () {
    final expectIdentity1 = Identity(
      id: IdentityId(Id('ac8f94d7-c548-4697-aea5-c4821ba07538')),
      email: 'somenamewithpeople@gmail.com',
      bcc: {},
      sortOrder: UnsignedInt(10000),
    );

    final expectIdentity2 = Identity(
        id: IdentityId(Id('f1e627f0-e21b-371a-9c03-ac74d06353fd')),
        email: 'somenamewithpeople@gmail.com',
        sortOrder: UnsignedInt(1000),
        bcc: {EmailAddress(null, "xyz@gmail.com")});

    test('get identity method and response parsing', () async {
      final baseOption = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onPost(
          '',
          (server) => server.reply(200, {
                "sessionState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                "methodResponses": [
                  [
                    "Identity/get",
                    {
                      "accountId":
                          "4603645929458bf671aca134b890cbb8ac4a0d297640f7eefe9f30ea28daa0b1",
                      "state": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                      "list": [
                        {
                          "email": "somenamewithpeople@gmail.com",
                          "id": "ac8f94d7-c548-4697-aea5-c4821ba07538",
                          "sortOrder": 10000,
                          "bcc": []
                        },
                        {
                          "email": "somenamewithpeople@gmail.com",
                          "id": "f1e627f0-e21b-371a-9c03-ac74d06353fd",
                          "sortOrder": 1000,
                          "bcc": [
                            {"email": "xyz@gmail.com"}
                          ]
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
              "urn:ietf:params:jmap:submission",
              "urn:apache:james:params:jmap:mail:identity:sortorder"
            ],
            "methodCalls": [
              [
                "Identity/get",
                {
                  "accountId":
                      "4603645929458bf671aca134b890cbb8ac4a0d297640f7eefe9f30ea28daa0b1",
                  "properties": ["email", "bcc", "sortOrder"]
                },
                "c0"
              ]
            ]
          },
          headers: {
            "accept": "application/json;jmapVersion=rfc-8621",
            "content-length": 466
          });

      final httpClient = HttpClient(dio);
      final processingInvocation = ProcessingInvocation();
      final requestBuilder =
          JmapRequestBuilder(httpClient, processingInvocation);
      final accountId = AccountId(Id(
          '4603645929458bf671aca134b890cbb8ac4a0d297640f7eefe9f30ea28daa0b1'));

      final getIdentityMethod = GetIdentityMethod(accountId)
        ..addProperties(Properties({"email", "bcc", "sortOrder"}));
      final getIdentityInvocation =
          requestBuilder.invocation(getIdentityMethod);
      final response = await (requestBuilder
            ..usings(getIdentityMethod.requiredCapabilitiesSupportSortOrder))
          .build()
          .execute();

      final resultList = response.parse<GetIdentityResponse>(
          getIdentityInvocation.methodCallId, GetIdentityResponse.deserialize);

      expect(resultList?.list.length, equals(2));
      expect(resultList?.list, containsAll({expectIdentity1, expectIdentity2}));
    });
  });
}
