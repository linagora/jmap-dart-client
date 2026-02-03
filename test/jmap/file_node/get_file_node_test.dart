import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/util/file_node_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  group('Stalwart FileNode - Live Test', () {
    test('FileNode/get', () async {
      final client =
          await createLiveClientFromFile(credentialsPath: 'test/jmap/credentials/auth_ietf.json');

      final httpClient = client.httpClient;
      final accountId = client.accountId;

      final resp = await FileNodeUtil.getFileNodes(
        client: httpClient,
        accountId: accountId,
      );

      expect(resp.accountId.id.value, equals(accountId.id.value));
      expect(resp.state.value, isNotEmpty);
      expect(resp.list, isNotNull);

      for (final node in resp.list) {
        expect(node.id?.value, isNotEmpty);
        expect(node.name, isNotNull);
      }
    });

    test('FileNode/get by id', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );

      final httpClient = client.httpClient;
      final accountId = client.accountId;

      final all = await FileNodeUtil.getFileNodes(
        client: httpClient,
        accountId: accountId,
      );

      expect(all.list.isNotEmpty, true);

      final first = all.list.first;
      final firstId = first.id?.value;
      expect(firstId, isNotEmpty);

      final fetched = await FileNodeUtil.getFileNodeById(
        client: httpClient,
        accountId: accountId,
        id: firstId!,
      );

      expect(fetched, isNotNull);
      expect(fetched!.id?.value, equals(firstId));
      expect(fetched.name, equals(first.name));
    });

    test('List all folders', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );

      final httpClient = client.httpClient;
      final accountId = client.accountId;
      final folders = await FileNodeUtil.listAllFolders(
        client: httpClient,
        accountId: accountId,
      );

      expect(folders, isNotNull);
    });

    test('download a text file', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );

      final http = client.httpClient;
      final accId = client.accountId;

      final name = "live_download_${DateTime.now().millisecondsSinceEpoch}.txt";
      const text = "Hello Live Download";

      final fileId = await FileNodeUtil.uploadFileFromText(
        client: http,
        accountId: accId,
        name: name,
        text: text,
      );

      expect(fileId, isNotNull);

      final result = await FileNodeUtil.downloadFile(
        client: http,
        accountId: accId,
        jmapPath: name,
      );

      expect(result, isA<String>());
      expect(result, text);
    });

    test('download  text file to local', () async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );

      final http = client.httpClient;
      final accId = client.accountId;

      final name = "live_local_${DateTime.now().millisecondsSinceEpoch}.txt";
      const text = "Local download test";

      final fileId = await FileNodeUtil.uploadFileFromText(
        client: http,
        accountId: accId,
        name: name,
        text: text,
      );

      expect(fileId, isNotNull);

      final local = "test_local_out_${DateTime.now().millisecondsSinceEpoch}.txt";

      await FileNodeUtil.downloadToLocal(
        client: http,
        accountId: accId,
        jmapPath: name,
        localPath: local, // local file path
      );

      final saved = await File(local).readAsString(); // read back the saved file
      expect(saved, text);

      await File(local).delete(); // clean up
    });
  });

  group('FileNode/get - mocked tests', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late HttpClient httpClient;

    const apiBase = 'https://mocked.test/jmap';
    final accountId = AccountId(Id('accFile'));

    setUp(() {
      dio = Dio(BaseOptions(method: 'POST', baseUrl: apiBase));
      dioAdapter = DioAdapter(dio: dio);
      httpClient = HttpClient(dio);
    });

    test('FileNode/get returns list via util', () async {
      dioAdapter.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "s1",
          "methodResponses": [
            [
              "FileNode/get",
              {
                "accountId": "accFile",
                "state": "st-1",
                "list": [
                  {"id": "f1", "name": "doc1.txt", "size": 100, "parentId": null},
                  {"id": "f2", "name": "photo.png", "size": 2048, "parentId": null}
                ],
                "notFound": []
              },
              "c0"
            ]
          ]
        }),
        data: {
          "methodCalls": [
            [
              "FileNode/get",
              {
                "accountId": "accFile",
                "properties": [
                  "id",
                  "name",
                  "blobId",
                  "size",
                  "parentId",
                  "type",
                  "created",
                  "modified",
                  "accessed",
                  "executable",
                  "isSubscribed",
                  "myRights",
                  "shareWith"
                ]
              },
              "c0"
            ]
          ],
          "using": ["urn:ietf:params:jmap:core", "urn:ietf:params:jmap:filenode"]
        },
      );


      final resp = await FileNodeUtil.getFileNodes(
        client: httpClient,
        accountId: accountId,
      );

      expect(resp.accountId.id.value, 'accFile');
      expect(resp.list.length, 2);

      expect(resp.list[0].id!.value, 'f1');
      expect(resp.list[0].name, 'doc1.txt');

      expect(resp.list[1].id!.value, 'f2');
      expect(resp.list[1].name, 'photo.png');
    });

    test('list all the folders, returns only folders', () async {
      dioAdapter.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "s1",
          "methodResponses": [
            [
              "FileNode/get",
              {
                "accountId": "accFile",
                "state": "st-1",
                "list": [
                  {"id": "f1", "name": "folderA", "parentId": null},
                  {"id": "f2", "name": "folderB", "parentId": "f1"},
                  {"id": "f3", "name": "file.txt", "blobId": "b123", "size": 55, "parentId": "f1"},
                ],
                "notFound": []
              },
              "c0"
            ]
          ]
        }),
        data: {
          "methodCalls": [
            [
              "FileNode/get",
              {
                "accountId": "accFile",
                "properties": [
                  "id",
                  "name",
                  "blobId",
                  "size",
                  "parentId",
                  "type",
                  "created",
                  "modified",
                  "accessed",
                  "executable",
                  "isSubscribed",
                  "myRights",
                  "shareWith"
                ]
              },
              "c0"
            ]
          ],
          "using": ["urn:ietf:params:jmap:core", "urn:ietf:params:jmap:filenode"]
        },
      );

      final folders = await FileNodeUtil.listAllFolders(
        client: httpClient,
        accountId: accountId,
      );

      expect(folders.length, 2);
      expect(folders[0].name, 'folderA');
      expect(folders[1].name, 'folderB');
    });
    test('returns a single fileNode', () async {
      dioAdapter.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "s1",
          "methodResponses": [
            [
              "FileNode/get",
              {
                "accountId": "accFile",
                "state": "st-1",
                "list": [
                  {
                    "id": "f123",
                    "name": "single.txt",
                    "blobId": "b987",
                    "size": 777,
                    "parentId": null
                  }
                ],
                "notFound": []
              },
              "c0"
            ]
          ]
        }),
        data: {
          "methodCalls": [
            [
              "FileNode/get",
              {
                "accountId": "accFile",
                "ids": ["f123"],
                "properties": [
                  "id",
                  "name",
                  "blobId",
                  "size",
                  "parentId",
                  "type",
                  "created",
                  "modified",
                  "accessed",
                  "executable",
                  "isSubscribed",
                  "myRights",
                  "shareWith"
                ]
              },
              "c0"
            ]
          ],
          "using": ["urn:ietf:params:jmap:core", "urn:ietf:params:jmap:filenode"]
        },
      );

      final node = await FileNodeUtil.getFileNodeById(
        client: httpClient,
        accountId: accountId,
        id: "f123",
      );

      expect(node, isNotNull);
      expect(node!.id!.value, 'f123');
      expect(node.name, 'single.txt');
      expect(node.blobId, 'b987');
      expect(node.size, 777);
    });
    test('downloads and returns blob content', () async {
      dioAdapter.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "s1",
          "methodResponses": [
            [
              "FileNode/get",
              {
                "accountId": "accFile",
                "state": "st-1",
                "list": [
                  {
                    "id": "f1",
                    "name": "doc.txt",
                    "blobId": "b1",
                  }
                ],
                "notFound": []
              },
              "c0"
            ]
          ]
        }),
        data: {
          "methodCalls": [
            [
              "FileNode/get",
              {
                "accountId": "accFile",
                "properties": [
                  "id",
                  "name",
                  "blobId",
                  "size",
                  "parentId",
                  "type",
                  "created",
                  "modified",
                  "accessed",
                  "executable",
                  "isSubscribed",
                  "myRights",
                  "shareWith"
                ]
              },
              "c0"
            ]
          ],
          "using": [
            "urn:ietf:params:jmap:core",
            "urn:ietf:params:jmap:filenode"
          ]
        },
      );

      dioAdapter.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "s1",
          "methodResponses": [
            [
              "Blob/get",
              {
                "accountId": "accFile",
                "state": "st-blob",
                "list": [
                  {
                    "blobId": "b1",
                    "type": "text/plain",
                    "size": 5,
                    "data:asText": "Hello"
                  }
                ],
                "notFound": []
              },
              "c0"
            ]
          ]
        }),
        data: {
          "methodCalls": [
            [
              "Blob/get",
              {
                "accountId": "accFile",
                "ids": ["b1"],
                "properties": [
                  "data:asText",
                  "data:asBase64",
                  "size",
                  "type"
                ]
              },
              "c0"
            ]
          ],
          "using": [
            "urn:ietf:params:jmap:core",
            "urn:ietf:params:jmap:blob"
          ]
        },
      );

      final result = await FileNodeUtil.downloadFile(
        client: httpClient,
        accountId: accountId,
        jmapPath: "doc.txt",
      );

      expect(result, isA<String>());
      expect(result, "Hello");
    });
  });
}
