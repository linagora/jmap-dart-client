import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/util/blob_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
 group('Blob/get - Live Test', () {
  late HttpClient httpClient;
  late AccountId accountId;
  late dynamic blobId;

  setUp(() async {
    final client = await createLiveClientFromFile(
      credentialsPath: 'test/jmap/credentials/auth_ietf.json',
    );
    httpClient = client.httpClient;
    accountId = client.accountId;

    blobId = (await BlobUtil.uploadBlobFromText(
      client: httpClient,
      accountId: accountId,
      content: "Hello from upload : get test!",
    ))!;
  });

  test('getBlob returns uploaded content', () async {
    final result = await BlobUtil.getBlob(
      client: httpClient,
      accountId: accountId,
      blobId: blobId.blobId!,
    );

    expect(result, isA<String>());
    expect(result, "Hello from upload : get test!");
  });
});

  group('blob/get - mocked', () {
    late Dio dio;
    late DioAdapter adapter;
    late HttpClient httpClient;
    final accountId = AccountId(Id("acc-mock"));

    setUp(() {
      dio = Dio(BaseOptions(method: 'POST', baseUrl: 'https://mock/jmap'));
      adapter = DioAdapter(dio: dio);
      httpClient = HttpClient(dio);
    });

    test('getBlob using BlobId', () async {

      adapter.onPost(
        '',
        (s) => s.reply(200, {
          "sessionState": "s-test",
          "methodResponses": [
            [
              "Blob/upload",
              {
                "accountId": "acc-mock",
                "created": {
                  "auto": {
                    "id": "blob_12345",
                    "size": 42
                  }
                }
              },
              "c0"
            ]
          ]
        }),
        data: Matchers.any,
      );

      final blobId = await BlobUtil.uploadBlobFromText(
        client: httpClient,
        accountId: accountId,
        content: "Hello mock blob!",
        clientId: Id("auto"),
      );

      expect(blobId!.blobId, "blob_12345");
      expect(blobId.size, 42);
      

      adapter.onPost(
        '',
        (s) => s.reply(200, {
          "sessionState": "s-test",
          "methodResponses": [
            [
              "Blob/get",
              {
                "accountId": "acc-mock",
                "list": [
                  {
                    "blobId": "blob_12345",
                    "size": 42,
                    "data:asText": "Hello mock blob!"
                  }
                ],
                "notFound": []
              },
              "c0"
            ]
          ]
        }),
        data: Matchers.any,
      );

      final result = await BlobUtil.getBlob(
        client: httpClient,
        accountId: accountId,
        blobId: blobId.blobId!,
      );

      expect(result, isA<String>());
      expect(result, "Hello mock blob!");
    });
  });
}
