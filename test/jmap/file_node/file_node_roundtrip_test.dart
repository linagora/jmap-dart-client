import 'package:flutter_test/flutter_test.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/util/blob_util.dart';
import 'package:jmap_dart_client/util/file_node_util.dart';
import 'package:jmap_dart_client/util/session_util.dart';

void main() {
  group('IETF FileNode - Live Round-Trip Tests', () {
    late HttpClient httpClient;
    late AccountId accountId;

    String? createdFileNodeId;

    setUp(() async {
      final client = await createLiveClientFromFile(
        credentialsPath: 'test/jmap/credentials/auth_ietf.json',
      );
      httpClient = client.httpClient;
      accountId = client.accountId;
    });

    test(
        'roundtrip: upload blob -> create filenode -> get filenode -> get blob -> delete filenode',
        () async {
      const text = 'New test case for roundtrip calculation!';

      final blob = await BlobUtil.uploadBlobFromText(
        client: httpClient,
        accountId: accountId,
        content: text,
      );

      expect(blob, isNotNull);
      expect(blob!.blobId, isNotEmpty);

      final fileName =
          'roundtrip_${DateTime.now().millisecondsSinceEpoch}.txt';

      createdFileNodeId = await FileNodeUtil.uploadFileFromText(
        client: httpClient,
        accountId: accountId,
        name: fileName,
        text: text,
      );

      expect(createdFileNodeId, isNotNull);
      expect(createdFileNodeId!.isNotEmpty, true);

      final allNodesBeforeDelete = await FileNodeUtil.getFileNodes(
        client: httpClient,
        accountId: accountId,
      );

      final fetched = allNodesBeforeDelete.list.firstWhere(
        (n) => n.id?.value == createdFileNodeId,
        orElse: () => throw Exception('FileNode not found'),
      );

      expect(fetched.name, fileName);
      expect(fetched.blobId, isNotNull);

      final blobData = await BlobUtil.getBlob(
        client: httpClient,
        accountId: accountId,
        blobId: fetched.blobId!,
      );

      expect(blobData, text);

      await FileNodeUtil.deleteFileNode(
        client: httpClient,
        accountId: accountId,
        id: createdFileNodeId!,
      );

      final allNodesAfterDelete = await FileNodeUtil.getFileNodes(
        client: httpClient,
        accountId: accountId,
      );

      final stillExists = allNodesAfterDelete.list.any(
        (n) => n.id?.value == createdFileNodeId,
      );

      expect(stillExists, false);

      createdFileNodeId = null;
    });

    tearDown(() async {
      if (createdFileNodeId == null) return;

      await FileNodeUtil.deleteFileNode(
        client: httpClient,
        accountId: accountId,
        id: createdFileNodeId!,
      );

      createdFileNodeId = null;
    });
  });
}
