import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/file_node/file_node.dart';
import 'package:jmap_dart_client/util/file_node_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  
  //create unique file names
  String unique(String name) {
    final ts = DateTime.now().millisecondsSinceEpoch;
    return "$ts-$name";
  }

  group('IETF FileNode - Live API Tests', () {
    late HttpClient httpClient;
    late AccountId accountId;

    setUp(() async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );
      httpClient = client.httpClient;
      accountId = client.accountId;
    });

    test('Simple Blob/upload + FileNode/set', () async {
      const text = "Hello from simple file upload test!";
      final fileId = await FileNodeUtil.uploadFileFromText(
        client: httpClient,
        accountId: accountId,
        name: unique("testfile.txt"),
        text: text,
      );

      expect(fileId, isNotNull);
      expect(fileId!.isNotEmpty, true);
    });

    test('Upload JSON text file', () async {
      const jsonText = '{"hello": "world", "value": 42}';
      final fileId = await FileNodeUtil.uploadFileFromText(
        client: httpClient,
        accountId: accountId,
        name: unique("data.json"),
        text: jsonText,
      );

      expect(fileId, isNotNull);
      expect(fileId!.isNotEmpty, true);
    });

    test('Upload file into nested folder path', () async {
      const text = "file in nested folder";
      final fileId = await FileNodeUtil.uploadFileFromText(
        client: httpClient,
        accountId: accountId,
        name: "folderA/folderB/${unique("test_nested.txt")}",
        text: text,
      );

      expect(fileId, isNotNull);
      expect(fileId!.isNotEmpty, true);
    });

    test('Upload binary file (PNG bytes)', () async {
      final bytes = Uint8List.fromList([137, 80, 78, 71]);
      final fileId = await FileNodeUtil.uploadFileFromBytes(
        client: httpClient,
        accountId: accountId,
        name: unique("image.png"),
        bytes: bytes,
      );

      expect(fileId, isNotNull);
      expect(fileId!.isNotEmpty, true);
    });

    test('Upload binary list<int>', () async {
      final data = [1, 2, 3, 4, 255];
      final fileId = await FileNodeUtil.uploadFile(
        client: httpClient,
        accountId: accountId,
        name: unique("numbers.bin"),
        content: data,
      );

      expect(fileId, isNotNull);
      expect(fileId!.isNotEmpty, true);
    });

    test('Upload local file by path', () async {
      final tmp = File("test_local_upload.txt");
      await tmp.writeAsString("local upload test");

      final fileId = await FileNodeUtil.uploadFile(
        client: httpClient,
        accountId: accountId,
        name: unique("uploaded_local.txt"),
        content: tmp.path,
      );

      expect(fileId, isNotNull);
      expect(fileId!.isNotEmpty, true);

      await tmp.delete();
    });
    test('Create folders, list all folders and verify parent-child hierarchy', () async {
      final folder2 = "nested_${DateTime.now().millisecondsSinceEpoch}";
      const subName = "sub";

      // Create folder2/sub
      await FileNodeUtil.uploadFileFromText(
        client: httpClient,
        accountId: accountId,
        name: "$folder2/$subName/test2.txt",
        text: "sample2",
      );

      // Fetch all folders
      final folders = await FileNodeUtil.listAllFolders(
        client: httpClient,
        accountId: accountId,
      );

      // Find all "sub" folders
      final subs = folders.where((f) => f.name == subName).toList();
      expect(subs.isNotEmpty, true);

      // Find all folder2 folders
      final parents = folders.where((f) => f.name == folder2).toList();
      expect(parents.isNotEmpty, true);

      // Find "sub" whose parent name == folder2
      final matched = subs.where((s) {
        final parent = folders.firstWhere(
          (f) => f.id?.value == s.parentId?.value,
          orElse: () => FileNode(name: ""),
        );
        return parent.name == folder2;
      }).toList();

      expect(matched.isNotEmpty, true,
          reason: "There must be a sub folder under $folder2");
    });

    test('FileNode/update live - rename file', () async {
      const text = "content before update";

      // create file
      final fileId = await FileNodeUtil.uploadFileFromText(
        client: httpClient,
        accountId: accountId,
        name: unique("update_test.txt"),
        text: text,
      );

      expect(fileId, isNotNull);

      // update file name
      final newName = unique("updated_name.txt");
      final patch = PatchObject({
        "name": newName,
      });

      final updateResp = await FileNodeUtil.updateFileNode(
        client: httpClient,
        accountId: accountId,
        id: Id(fileId!),
        patch: patch,
      );

      expect(updateResp, isNotNull);

      // fetch and verify
      final updated = await FileNodeUtil.getFileNodeById(
        client: httpClient,
        accountId: accountId,
        id: fileId,
      );

      expect(updated, isNotNull);
      expect(updated!.name, newName);
    });
  });

  group('FileNode/set - mocked tests', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late HttpClient httpClient;

    const apiBase = "https://mocked.test/jmap";
    final accountId = AccountId(Id('accFile'));

    setUp(() {
      dio = Dio(BaseOptions(method: 'POST', baseUrl: apiBase));
      dioAdapter = DioAdapter(dio: dio);
      httpClient = HttpClient(dio);
    });

    test('FileNode/set mocked', () async {
      dioAdapter.onPost(
        '',
        (server) => server.reply(200, {
          "sessionState": "s2",
          "methodResponses": [
            [
              "FileNode/set",
              {
                "accountId": "accFile",
                "oldState": "st-old",
                "newState": "st-new",
                "created": {
                  "fNew": {
                    "id": "fNew",
                    "name": "newfile.txt",
                    "size": 20
                  }
                },
                "updated": {
                  "f1": {
                    "id": "f1",
                    "name": "doc1-renamed.txt",
                    "size": 100
                  }
                },
                "destroyed": ["f2"]
              },
              "c0"
            ]
          ]
        }),
        data: {
          "methodCalls": [
            [
              "FileNode/set",
              {
                "accountId": "accFile",
                "create": {
                  "fNew": {"name": "newfile.txt", "type": "text/plain"}
                },
                "update": {
                  "f1": {"name": "doc1-renamed.txt"}
                },
                "destroy": ["f2"]
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

      final resp = await FileNodeUtil.setFileNodes(
        client: httpClient,
        accountId: accountId,
        create: {
          Id("fNew"): FileNode(name: "newfile.txt", type: "text/plain")
        },
        update: {
          Id("f1"): PatchObject({"name": "doc1-renamed.txt"})
        },
        destroy: {Id("f2")},
        methodCallId: MethodCallId("c0"),
      );

      expect(resp.accountId.id.value, 'accFile');
      expect(resp.destroyed!.first.value, 'f2');
    });
  });
}
