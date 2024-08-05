import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/identities/identity.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/extensions/public_asset/get/get_public_asset_method.dart';
import 'package:jmap_dart_client/jmap/mail/extensions/public_asset/get/get_public_asset_response.dart';
import 'package:jmap_dart_client/jmap/mail/extensions/public_asset/public_asset.dart';

void main() {
  final baseOption = BaseOptions(method: 'POST');
  final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
  final dioAdapter = DioAdapter(dio: dio);
  final dioAdapterHeaders = {"accept": "application/json;jmapVersion=rfc-8621"};
  final httpClient = HttpClient(dio);
  final processingInvocation = ProcessingInvocation();
  final requestBuilder = JmapRequestBuilder(httpClient, processingInvocation);
  final accountId = AccountId(Id('123abc'));
  final identityId = IdentityId(Id('some-identity-id'));
  final methodCallId = MethodCallId('c0');
  final publicAsset = PublicAsset(
    id: Id('abc123'),
    blobId: Id('def456'),
    size: 123,
    contentType: 'image/jpeg',
    publicURI: 'http://domain.com/public/abc123',
    identityIds: {identityId: true}
  );
  
  group('get public asset method test:', () {
    test(
      'should return expected PublicAsset '
      'when call method PublicAsset/get with exist public asset id',
    () async {
      // arrange
      final getPublicAssetMethod = GetPublicAssetMethod(accountId)..addIds({publicAsset.id!});
      final invocation = requestBuilder.invocation(getPublicAssetMethod, methodCallId: methodCallId);
      dioAdapter.onPost(
        '',
        (server) => server.reply(
          200,
          {
            "sessionState": "abcdefghij",
            "methodResponses": [[
              getPublicAssetMethod.methodName.value,
              {
                "accountId": accountId.id.value,
                "state": 'some-state',
                "list": [publicAsset.toJson()],
                "notFound": [],
              },
              methodCallId.value
            ]]
          }
        ),
        data: {
          "using": getPublicAssetMethod.requiredCapabilities
            .map((capability) => capability.value.toString())
            .toList(),
          "methodCalls": [
            [
              getPublicAssetMethod.methodName.value,
              {
                "accountId": accountId.id.value,
                "ids": [publicAsset.id?.value],
              },
              methodCallId.value
            ]
          ]
        },
        headers: dioAdapterHeaders,
      );

      // act
      final response = (await (requestBuilder..usings(getPublicAssetMethod.requiredCapabilities))
        .build()
        .execute())
          .parse<GetPublicAssetResponse>(
            invocation.methodCallId,
            GetPublicAssetResponse.deserialize);
      
      // assert
      expect((response)?.list, equals([publicAsset]));
    });

    test(
      'should return public asset id in notFound '
      'when call method PublicAsset/get with non-exist public asset id',
    () async {
      // arrange
      final getPublicAssetMethod = GetPublicAssetMethod(accountId)..addIds({publicAsset.id!});
      final invocation = requestBuilder.invocation(getPublicAssetMethod, methodCallId: methodCallId);
      dioAdapter.onPost(
        '',
        (server) => server.reply(
          200,
          {
            "sessionState": "abcdefghij",
            "methodResponses": [[
              getPublicAssetMethod.methodName.value,
              {
                "accountId": accountId.id.value,
                "state": 'some-state',
                "list": [],
                "notFound": [publicAsset.id?.value],
              },
              methodCallId.value
            ]]
          }
        ),
        data: {
          "using": getPublicAssetMethod.requiredCapabilities
            .map((capability) => capability.value.toString())
            .toList(),
          "methodCalls": [
            [
              getPublicAssetMethod.methodName.value,
              {
                "accountId": accountId.id.value,
                "ids": [publicAsset.id?.value],
              },
              methodCallId.value
            ]
          ]
        },
        headers: dioAdapterHeaders,
      );

      // act
      final response = (await (requestBuilder..usings(getPublicAssetMethod.requiredCapabilities))
        .build()
        .execute())
          .parse<GetPublicAssetResponse>(
            invocation.methodCallId,
            GetPublicAssetResponse.deserialize);
      
      // assert
      expect((response)?.notFound, equals([publicAsset.id]));
    });
  });
}