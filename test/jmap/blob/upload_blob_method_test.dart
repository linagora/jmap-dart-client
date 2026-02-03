import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/blob/blob.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/util/blob_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  group("Blob/upload - Live Tests", () {
    late HttpClient http;
    late AccountId accId;

    setUp(() async {
      final liveClient = await createLiveClientFromFile(
        credentialsPath: "test/jmap/credentials/auth_ietf.json",
      );
      http = liveClient.httpClient;
      accId = liveClient.accountId;
    });

    test('Blob/upload - multi-part upload using BlobUtil', () async {
      final b4Blob = Blob(
        data: [
          {"data:asText": "The quick brown fox jumped over the lazy dog."}
        ],
      );

      final catBlob = Blob(
        data: [
          {"data:asText": "How"},
          {"blobId": "#b4", "offset": 3, "length": 7},
          {"data:asText": "was t"},
          {"blobId": "#b4", "offset": 1, "length": 1},
          {"data:asBase64": "YXQ/"},
        ],
      );

      final result = await BlobUtil.uploadMultipart(
        client: http,
        accountId: accId,
        blobs: {
          Id("b4"): b4Blob,
          Id("cat"): catBlob,
        },
      );

      expect(result.containsKey(Id("b4")), true);
      expect(result.containsKey(Id("cat")), true);

      final b4Created = result[Id("b4")]!;
      final catCreated = result[Id("cat")]!;

      expect(b4Created.blobId, isNotEmpty);
      expect(b4Created.size, greaterThan(0));

      expect(catCreated.blobId, isNotEmpty);
      expect(catCreated.size, greaterThan(0));

      // verifying the data contents is done by round-trip tests
      // as additional Blob/get is needed
    });

    test("upload blob (text)", () async {
      final blobId = await BlobUtil.uploadBlobFromText(
        client: http,
        accountId: accId,
        content: "hello-live",
      );
      expect(blobId, isNotNull);
      expect(blobId!.blobId, isNotEmpty);

      // verifiying the data contents are done by round-trip 
      //tests as additional Blob/get is needed
    });

    test("upload blob (bytes)", () async {
      final data = Uint8List.fromList([1, 2, 3, 4]);
      final blobId = await BlobUtil.uploadBlobFromBytes(
        client: http,
        accountId: accId,
        content: data,
      );
      expect(blobId!.blobId, isNotNull);

      // verifiying the data contents are done by round-trip 
      //tests as additional Blob/get is needed
    });
  });
  group("Blob/upload - Mocked Tests", () {
    late Dio dio;
    late DioAdapter mock;
    late HttpClient http;
    final accId = AccountId(Id("accMock"));

    setUp(() {
      dio = Dio(BaseOptions(method: "POST", baseUrl: "https://mock/jmap"));
      mock = DioAdapter(dio: dio);
      http = HttpClient(dio);
    });

    test("uploadBlob (simple text)", () async {
      mock.onPost(
        "",
        (s) => s.reply(200, {
          "sessionState": "s",
          "methodResponses": [
            [
              "Blob/upload",
              {
                "accountId": "accMock",
                "created": {
                  "auto": {"id": "blob123", "size": 5}
                }
              },
              "c0"
            ]
          ]
        }),
        data: Matchers.any,
      );

      final blob = await BlobUtil.uploadBlobFromText(
        client: http,
        accountId: accId,
        content: "abc",
        clientId: Id("auto"),
      );

      expect(blob!.blobId, "blob123");
      expect(blob.size, 5);
    });

    test("uploadBlob (bytes)", () async {
      mock.onPost(
        "",
        (s) => s.reply(200, {
          "sessionState": "s",
          "methodResponses": [
            [
              "Blob/upload",
              {
                "accountId": "accMock",
                "created": {
                  "auto": {"id": "b64_1", "size": 3}
                }
              },
              "c0"
            ]
          ]
        }),
        data: Matchers.any,
      );

      final blob = await BlobUtil.uploadBlobFromBytes(
        client: http,
        accountId: accId,
        content: Uint8List.fromList([1, 2, 3]),
        clientId: Id("auto"),
      );

      expect(blob!.blobId, "b64_1");
      expect(blob.size, 3);
    });
    test("uploadBlob (file path)", () async {
      final tmpFile = File("tmp_mock.txt");
      await tmpFile.writeAsString("mockdata");

      mock.onPost(
        "",
        (s) => s.reply(200, {
          "sessionState": "s",
          "methodResponses": [
            [
              "Blob/upload",
              {
                "accountId": "accMock",
                "created": {
                  "auto": {"id": "file_blob", "size": 8}
                }
              },
              "c0"
            ]
          ]
        }),
        data: Matchers.any,
      );

      final blob = await BlobUtil.uploadBlobFromFile(
        client: http,
        accountId: accId,
        file: tmpFile,
        clientId: Id("auto"),
      );

      expect(blob!.blobId, "file_blob");
      expect(blob.size, 8);

      await tmpFile.delete();
    });
  });
}
