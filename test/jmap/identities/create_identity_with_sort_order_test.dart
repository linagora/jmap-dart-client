import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/identities/identity.dart';
import 'package:jmap_dart_client/jmap/identities/set/set_identity_method.dart';
import 'package:jmap_dart_client/jmap/identities/set/set_identity_response.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';

void main() {
  group('test to json set identity method', () {
    final expectedCreated = Identity(
      id: IdentityId(Id('5ccf6d7b-77e8-467a-9064-9f7ccfb19e86')),
      sortOrder: UnsignedInt(99999),
    );

    test('create new identity with sort order method and response parsing',
        () async {
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
                          "4603645929458bf671aca134b890cbb8ac4a0d297640fsdefe9230ea28daa0b1",
                      "newState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                      "created": {
                        "dab246": {
                          "id": "5ccf6d7b-77e8-467a-9064-9f7ccfb19e86",
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
              "urn:ietf:params:jmap:submission",
              "urn:apache:james:params:jmap:mail:identity:sortorder"
            ],
            "methodCalls": [
              [
                "Identity/set",
                {
                  "accountId":
                      "4603645929458bf671aca134b890cbb8ac4a0d297640fsdefe9230ea28daa0b1",
                  "create": {
                    "dab246": {
                      "name": "User B23",
                      "email": "lol@gmail.com",
                      "textSignature": "",
                      "htmlSignature":
                          "<body><div>Dat T. Vu <br>Mobile Engineer <br>LINAGORA VIETNAM <br>A: 8th Floor (Toong VPBank Tower, No. 5 Dien Bien Phu  Str., Ba Dinh Dist., Ha Noi <br>P: (+84) 366-769-439<br>E: tdvu@linagora.com</div></body>",
                      "sortOrder": 99999
                    }
                  }
                },
                "c0"
              ]
            ]
          },
          headers: {
            "accept": "application/json;jmapVersion=rfc-8621",
            "content-length": 949
          });

      final setIdentityMethod = SetIdentityMethod(AccountId(Id(
          '4603645929458bf671aca134b890cbb8ac4a0d297640fsdefe9230ea28daa0b1')))
        ..addCreate(
            Id('dab246'),
            Identity(
              name: 'User B23',
              email: 'lol@gmail.com',
              textSignature: Signature(''),
              htmlSignature: Signature(
                  '<body><div>Dat T. Vu <br>Mobile Engineer <br>LINAGORA VIETNAM <br>A: 8th Floor (Toong VPBank Tower, No. 5 Dien Bien Phu  Str., Ba Dinh Dist., Ha Noi <br>P: (+84) 366-769-439<br>E: tdvu@linagora.com</div></body>'),
              sortOrder: UnsignedInt(99999),
            ));

      final httpClient = HttpClient(dio);
      final requestBuilder =
          JmapRequestBuilder(httpClient, ProcessingInvocation());
      final setIdentityInvocation =
          requestBuilder.invocation(setIdentityMethod);
      final response = await (requestBuilder
            ..usings(setIdentityMethod.requiredCapabilitiesSupportSortOrder))
          .build()
          .execute();

      final setIdentityResponse = response.parse<SetIdentityResponse>(
          setIdentityInvocation.methodCallId, SetIdentityResponse.deserialize);

      expect(setIdentityResponse!.created![Id('dab246')]!.id,
          equals(expectedCreated.id));
    });
  });

  group(
      'test increase of old default identity request and create new identity request',
      () {
    final expectedCreated = Identity(
      id: IdentityId(Id('5ccf6d7b-77e8-467a-9064-9f7ccfb19e12')),
      sortOrder: UnsignedInt(1),
    );

    test(
        'test increase of old default identity request and create new identity request',
        () async {
      final baseOption = BaseOptions(method: 'POST');
      final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
      final dioAdapter = DioAdapter(dio: dio);
      dioAdapter.onPost(
          '',
          (server) => server.reply(200, {
                "sessionState": "2c9f1b12-b35a-43e6-9af2-0106f123a943",
                "methodResponses": [
                  [
                    "Identity/set",
                    {
                      "accountId":
                          "4603645929458bf671aca134b890cbb8ac4a0d297640fsdefe9230ea28daa0b1",
                      "newState": "2c9f1b12-b35a-43e6-9af2-0106fb53a943",
                      "created": {
                        "xyz123": {
                          "id": "5ccf6d7b-77e8-467a-9064-9f7ccfb19e12",
                          "mayDelete": true,
                        }
                      },
                      "updated": {"5ccf6d7b-77e8-467a-9064-9f7cc1234512": {}}
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
                "Identity/set",
                {
                  "accountId":
                      "4603645929458bf671aca134b890cbb8ac4a0d297640fsdefe9230ea28daa0b1",
                  "create": {
                    "xyz123": {
                      "id": "5ccf6d7b-77e8-467a-9064-9f7ccfb19e12",
                      "name": "User B23",
                      "email": "lol@gmail.com",
                      "sortOrder": 1
                    }
                  },
                  "update": {
                    "c6ba359f-94a8-4ee9-b515-6bd2d9698618": {"sortOrder": 8888}
                  }
                },
                "c0"
              ]
            ]
          },
          headers: {
            "accept": "application/json;jmapVersion=rfc-8621",
            "content-length": 728
          });

      final setIdentityMethod = SetIdentityMethod(AccountId(Id(
          '4603645929458bf671aca134b890cbb8ac4a0d297640fsdefe9230ea28daa0b1')))
        ..addCreate(
            Id('xyz123'),
            Identity(
                id: IdentityId(Id("5ccf6d7b-77e8-467a-9064-9f7ccfb19e12")),
                name: 'User B23',
                email: 'lol@gmail.com',
                sortOrder: UnsignedInt(1)))
        ..addUpdates({
          Id("c6ba359f-94a8-4ee9-b515-6bd2d9698618"):
              PatchObject({"sortOrder": 8888})
        });

      final httpClient = HttpClient(dio);
      final requestBuilder =
          JmapRequestBuilder(httpClient, ProcessingInvocation());
      final setIdentityInvocation =
          requestBuilder.invocation(setIdentityMethod);
      final response = await (requestBuilder
            ..usings(setIdentityMethod.requiredCapabilitiesSupportSortOrder))
          .build()
          .execute();

      final setIdentityResponse = response.parse<SetIdentityResponse>(
          setIdentityInvocation.methodCallId, SetIdentityResponse.deserialize);

      expect(setIdentityResponse!.created![Id('xyz123')]!.id,
          equals(expectedCreated.id));
      expect(
          setIdentityResponse
              .updated![Id('5ccf6d7b-77e8-467a-9064-9f7cc1234512')],
          equals(Identity()));
    });
  });
}
