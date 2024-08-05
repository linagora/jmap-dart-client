import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/converter/identities/public_asset_identities_converter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/error/set_error.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/identities/identity.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/extensions/public_asset/public_asset.dart';
import 'package:jmap_dart_client/jmap/mail/extensions/public_asset/set/set_public_asset_method.dart';
import 'package:jmap_dart_client/jmap/mail/extensions/public_asset/set/set_public_asset_response.dart';

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
  
  group('set public asset method test:', () {
    test(
      'should return created public asset '
      'when PublicAsset/set create return success',
    () async {
      // arrange
      final createId = Id('def456');
      final createObject = PublicAsset(
        blobId: publicAsset.blobId,
        identityIds: publicAsset.identityIds);
      final method = SetPublicAssetMethod(accountId)
        ..addCreate(createId, createObject);
      final invocation = requestBuilder.invocation(method, methodCallId: methodCallId);
      dioAdapter.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "abcdefghij",
          "methodResponses": [[
            method.methodName.value,
            {
              "accountId": accountId.id.value,
              "newState": 'some-state',
              "created": {createId.value: publicAsset.toJson()},
            },
            methodCallId.value
          ]]
        }),
        data: {
          "using": method.requiredCapabilities
            .map((capability) => capability.value.toString())
            .toList(),
          "methodCalls": [
            [
              method.methodName.value,
              {
                "accountId": accountId.id.value,
                "create": {createId.value: createObject.toJson()},
              },
              methodCallId.value
            ],
          ]
        },
        headers: dioAdapterHeaders,
      );

      // act
      final response = (await (requestBuilder..usings(method.requiredCapabilities))
        .build()
        .execute())
          .parse<SetPublicAssetResponse>(
            invocation.methodCallId,
            SetPublicAssetResponse.deserialize);
      
      // assert
      expect(response?.created, equals({createId: publicAsset}));
    });

    test(
      'should return notCreated '
      'when PublicAsset/set create return failure',
    () async {
      // arrange
      const errorDescription = 'Missing \'/blobId\' property';
      final createId = Id('def456');
      final createObject = PublicAsset(
        blobId: null,
        identityIds: publicAsset.identityIds);
      final method = SetPublicAssetMethod(accountId)
        ..addCreate(createId, createObject);
      final invocation = requestBuilder.invocation(method, methodCallId: methodCallId);
      dioAdapter.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "abcdefghij",
          "methodResponses": [[
            method.methodName.value,
            {
              "accountId": accountId.id.value,
              "oldState": 'some-old-state',
              "newState": 'some-state',
              "notCreated": {
                createId.value: {
                  "type": "invalidArguments",
                  "description": errorDescription
                }
              }
            },
            methodCallId.value
          ]]
        }),
        data: {
          "using": method.requiredCapabilities
            .map((capability) => capability.value.toString())
            .toList(),
          "methodCalls": [
            [
              method.methodName.value,
              {
                "accountId": accountId.id.value,
                "create": {createId.value: createObject.toJson()},
              },
              methodCallId.value
            ],
          ]
        },
        headers: dioAdapterHeaders,
      );

      // act
      final response = (await (requestBuilder..usings(method.requiredCapabilities))
        .build()
        .execute())
          .parse<SetPublicAssetResponse>(
            invocation.methodCallId,
            SetPublicAssetResponse.deserialize);
      
      // assert
      expect(
        response?.notCreated?[createId],
        SetError(SetError.invalidArguments, description: errorDescription),
      );
    });

    test(
      'should return destroyed public asset ids '
      'when PublicAsset/set destroy return success',
    () async {
      // arrange
      final method = SetPublicAssetMethod(accountId)
        ..addDestroy({publicAsset.id!});
      final invocation = requestBuilder.invocation(method, methodCallId: methodCallId);
      dioAdapter.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "abcdefghij",
          "methodResponses": [[
            method.methodName.value,
            {
              "accountId": accountId.id.value,
              "newState": 'some-state',
              "destroyed": [publicAsset.id?.value],
            },
            methodCallId.value
          ]]
        }),
        data: {
          "using": method.requiredCapabilities
            .map((capability) => capability.value.toString())
            .toList(),
          "methodCalls": [
            [
              method.methodName.value,
              {
                "accountId": accountId.id.value,
                "destroy": [publicAsset.id?.value],
              },
              methodCallId.value
            ],
          ]
        },
        headers: dioAdapterHeaders,
      );

      // act
      final response = (await (requestBuilder..usings(method.requiredCapabilities))
        .build()
        .execute())
          .parse<SetPublicAssetResponse>(
            invocation.methodCallId,
            SetPublicAssetResponse.deserialize);
      
      // assert
      expect(response?.destroyed, equals({publicAsset.id}));
    });

    test(
      'should return notDestroyed '
      'when PublicAsset/set destroy return failure',
    () async {
      // arrange
      String errorDescription(String? id) => 'Invalid UUID string: $id';
      final method = SetPublicAssetMethod(accountId)
        ..addDestroy({publicAsset.id!});
      final invocation = requestBuilder.invocation(method, methodCallId: methodCallId);
      dioAdapter.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "abcdefghij",
          "methodResponses": [[
            method.methodName.value,
            {
              "accountId": accountId.id.value,
              "oldState": 'some-old-state',
              "newState": 'some-state',
              "notDestroyed": {
                publicAsset.id?.value: {
                  "type": "invalidArguments",
                  "description": errorDescription(publicAsset.id?.value)
                }
              }
            },
            methodCallId.value
          ]]
        }),
        data: {
          "using": method.requiredCapabilities
            .map((capability) => capability.value.toString())
            .toList(),
          "methodCalls": [
            [
              method.methodName.value,
              {
                "accountId": accountId.id.value,
                "destroy": [publicAsset.id?.value],
              },
              methodCallId.value
            ],
          ]
        },
        headers: dioAdapterHeaders,
      );

      // act
      final response = (await (requestBuilder..usings(method.requiredCapabilities))
        .build()
        .execute())
          .parse<SetPublicAssetResponse>(
            invocation.methodCallId,
            SetPublicAssetResponse.deserialize);
      
      // assert
      expect(
        response?.notDestroyed?[publicAsset.id],
        SetError(SetError.invalidArguments, description: errorDescription(publicAsset.id?.value)),
      );
    });

    test(
      'should return updated public asset ids '
      'when PublicAsset/set update return success',
    () async {
      // arrange
      final updateObject = PatchObject({
        PatchObject.identityIdsProperty: const PublicAssetIdentitiesConverter()
          .toJson(publicAsset.identityIds!),
      });
      final method = SetPublicAssetMethod(accountId)
        ..addUpdates({publicAsset.id!: updateObject});
      final invocation = requestBuilder.invocation(method, methodCallId: methodCallId);
      dioAdapter.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "abcdefghij",
          "methodResponses": [[
            method.methodName.value,
            {
              "accountId": accountId.id.value,
              "newState": 'some-state',
              "updated": {publicAsset.id?.value: null},
            },
            methodCallId.value
          ]]
        }),
        data: {
          "using": method.requiredCapabilities
            .map((capability) => capability.value.toString())
            .toList(),
          "methodCalls": [
            [
              method.methodName.value,
              {
                "accountId": accountId.id.value,
                "update": {publicAsset.id?.value: updateObject.toJson()},
              },
              methodCallId.value
            ],
          ]
        },
        headers: dioAdapterHeaders,
      );

      // act
      final response = (await (requestBuilder..usings(method.requiredCapabilities))
        .build()
        .execute())
          .parse<SetPublicAssetResponse>(
            invocation.methodCallId,
            SetPublicAssetResponse.deserialize);
      
      // assert
      expect(response?.updated, equals({publicAsset.id: null}));
    });

    test(
      'should return notUpdated '
      'when PublicAsset/set update return failure',
    () async {
      // arrange
      const errorDescription = 'Invalid identity';
      final updateObject = PatchObject({
        PatchObject.identityIdsProperty: const PublicAssetIdentitiesConverter()
          .toJson(publicAsset.identityIds!),
      });
      final method = SetPublicAssetMethod(accountId)
        ..addUpdates({publicAsset.id!: updateObject});
      final invocation = requestBuilder.invocation(method, methodCallId: methodCallId);
      dioAdapter.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "abcdefghij",
          "methodResponses": [[
            method.methodName.value,
            {
              "accountId": accountId.id.value,
              "oldState": 'some-old-state',
              "newState": 'some-state',
              "notUpdated": {
                publicAsset.id?.value: {
                  "type": "invalidArguments",
                  "description": errorDescription
                }
              }
            },
            methodCallId.value
          ]]
        }),
        data: {
          "using": method.requiredCapabilities
            .map((capability) => capability.value.toString())
            .toList(),
          "methodCalls": [
            [
              method.methodName.value,
              {
                "accountId": accountId.id.value,
                "update": {publicAsset.id?.value: updateObject.toJson()},
              },
              methodCallId.value
            ],
          ]
        },
        headers: dioAdapterHeaders,
      );

      // act
      final response = (await (requestBuilder..usings(method.requiredCapabilities))
        .build()
        .execute())
          .parse<SetPublicAssetResponse>(
            invocation.methodCallId,
            SetPublicAssetResponse.deserialize);
      
      // assert
      expect(
        response?.notUpdated?[publicAsset.id],
        SetError(SetError.invalidArguments, description: errorDescription),
      );
    });
  });
}