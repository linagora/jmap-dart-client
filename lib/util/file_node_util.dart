import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/properties/properties.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/file_node/file_node.dart';
import 'package:jmap_dart_client/jmap/file_node/get/get_file_node_method.dart';
import 'package:jmap_dart_client/jmap/file_node/get/get_file_node_response.dart';
import 'package:jmap_dart_client/jmap/file_node/set/set_file_node_method.dart';
import 'package:jmap_dart_client/jmap/file_node/set/set_file_node_response.dart';
import 'package:jmap_dart_client/jmap/file_node/changes/changes_file_node_method.dart';
import 'package:jmap_dart_client/jmap/file_node/changes/changes_file_node_response.dart';
import 'package:jmap_dart_client/jmap/file_node/path_resolver.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'blob_util.dart';

class FileNodeUtil {
  FileNodeUtil._();

  /// Resolves file name and parent folder.
  /// If parentId is null and name contains folders, ensures the folder path exists.
  static Future<ResolvedPath> _resolvePathAndParent({
    required HttpClient client,
    required AccountId accountId,
    required String name,
    Id? parentId,
  }) async {
    final parts = name.split('/');
    final fileName = parts.last;
    final folderPath =
        parts.length > 1 ? parts.sublist(0, parts.length - 1).join('/') : "";
    Id? resolvedParent = parentId;
    if (resolvedParent == null && folderPath.isNotEmpty) {
      final folderNode = await ensureFolderPath(
        client: client,
        accountId: accountId,
        folderPath: folderPath,
      );
      resolvedParent = folderNode?.id;
    }
    return ResolvedPath(fileName, resolvedParent);
  }

  /// Sends FileNode/set.
  static Future<SetFileNodeResponse> setFileNodes({
    required HttpClient client,
    required AccountId accountId,
    Map<Id, FileNode>? create,
    Map<Id, PatchObject>? update,
    Set<Id>? destroy,
    MethodCallId? methodCallId,
  }) async {
    final method = SetFileNodeMethod(accountId);
    if (create != null && create.isNotEmpty) method.create = create;
    if (update != null && update.isNotEmpty) method.update = update;
    if (destroy != null && destroy.isNotEmpty) method.destroy = destroy;
    return _executeSet(client, method, methodCallId: methodCallId);
  }

  /// Deletes a FileNode by id.
  /// Currently causes error on Stalwart JMAP servers.
  static Future<SetFileNodeResponse> deleteFileNode({
    required HttpClient client,
    required AccountId accountId,
    required String id,
  }) async {
    final method = SetFileNodeMethod(accountId)..destroy = {Id(id)};
    return await _executeSet(client, method);
  }

  /// Updates a FileNode using a patch object.
  static Future<SetFileNodeResponse> updateFileNode({
    required HttpClient client,
    required AccountId accountId,
    required Id id,
    required PatchObject patch,
  }) {
    return setFileNodes(
      client: client,
      accountId: accountId,
      update: {id: patch},
    );
  }

  /// Creates a folder node.
  static Future<String?> createFolder({
    required HttpClient client,
    required AccountId accountId,
    required String name,
    Id? parentId,
  }) async {
    final cid = Id("folder-${DateTime.now().microsecondsSinceEpoch % 1000000}");
    final method = SetFileNodeMethod(accountId)
      ..create = {cid: FileNode(name: name, parentId: parentId)};
    final resp = await _executeSet(client, method);
    return resp.created?[cid]?.id?.value;
  }

  /// Ensures that all folders in the given path exist.
  /// Existing folders are reused, and missing folders are created.
  /// Returns the FileNode representing the final folder in the path.
  static Future<FileNode?> ensureFolderPath({
    required HttpClient client,
    required AccountId accountId,
    required String folderPath,
  }) async {
    if (folderPath.isEmpty) throw Exception("Folder path is empty");
    final resp = await getFileNodes(client: client, accountId: accountId);
    final resolver = FileNodePathResolver(resp.list);
    final existing = resolver.resolve(folderPath);
    if (existing != null && existing.blobId == null) return existing;

    final parts = folderPath.split('/').where((p) => p.isNotEmpty).toList();
    FileNode? parent;
    String current = "";

    for (final part in parts) {
      current = current.isEmpty ? part : "$current/$part";
      final found = resolver.resolve(current);
      if (found != null && found.blobId == null) {
        parent = found;
        continue;
      }
      final newId = await createFolder(
        client: client,
        accountId: accountId,
        name: part,
        parentId: parent?.id,
      );
      if (newId == null) throw Exception("Failed to create folder $current");
      final newNode = FileNode(id: Id(newId), name: part, parentId: parent?.id);
      resp.list.add(newNode);
      parent = newNode;
    }
    return parent;
  }

  /// Uploads a file from any supported type.
  /// content can be text (String), bytes (Uint8List), or List<int>.
  static Future<String?> uploadFile({
    required HttpClient client,
    required AccountId accountId,
    required String name,
    required Object content,
    Id? parentId,
  }) async {
    final resolved = await _resolvePathAndParent(
      client: client,
      accountId: accountId,
      name: name,
      parentId: parentId,
    );

    if (content is String) {
      return uploadFileFromText(
        client: client,
        accountId: accountId,
        name: resolved.fileName,
        text: content,
        parentId: resolved.parentId,
      );
    }

    if (content is Uint8List) {
      return uploadFileFromBytes(
        client: client,
        accountId: accountId,
        name: resolved.fileName,
        bytes: content,
        parentId: resolved.parentId,
      );
    }

    if (content is List<int>) {
      return uploadFileFromBytes(
        client: client,
        accountId: accountId,
        name: resolved.fileName,
        bytes: Uint8List.fromList(content),
        parentId: resolved.parentId,
      );
    }
    throw ArgumentError('Unsupported upload type');
  }

  /// Uploads text content.
  static Future<String?> uploadFileFromText({
    required HttpClient client,
    required AccountId accountId,
    required String name,
    required String text,
    Id? parentId,
  }) async {
    final resolved = await _resolvePathAndParent(
      client: client,
      accountId: accountId,
      name: name,
      parentId: parentId,
    );

    final blob = await BlobUtil.uploadBlobFromText(
      client: client,
      accountId: accountId,
      content: text,
    );

    if (blob == null) {
      throw Exception('Blob upload failed for ${resolved.fileName}');
    }

    return _createFileNode(
      client: client,
      accountId: accountId,
      name: resolved.fileName,
      blobId: blob.blobId!,
      parentId: resolved.parentId,
    );
  }

   /// Uploads binary content.
  static Future<String?> uploadFileFromBytes({
    required HttpClient client,
    required AccountId accountId,
    required String name,
    required Uint8List bytes,
    Id? parentId,
  }) async {
    final resolved = await _resolvePathAndParent(
      client: client,
      accountId: accountId,
      name: name,
      parentId: parentId,
    );

    final blob = await BlobUtil.uploadBlobFromBytes(
      client: client,
      accountId: accountId,
      content: bytes,
    );

    if (blob == null) {
      throw Exception('Blob upload failed for ${resolved.fileName}');
    }

    return _createFileNode(
      client: client,
      accountId: accountId,
      name: resolved.fileName,
      blobId: blob.blobId!,
      parentId: resolved.parentId,
    );
  }

  /// Uploads a file from disk.
  static Future<String?> uploadFileFromPath({
    required HttpClient client,
    required AccountId accountId,
    required String path,
    String? name,
    Id? parentId,
  }) async {
    final file = File(path);
    if (!file.existsSync()) {
      throw ArgumentError("File does not exist: $path");
    }

    final bytes = await file.readAsBytes();
    final fileName = name ?? file.uri.pathSegments.last;

    return uploadFileFromBytes(
      client: client,
      accountId: accountId,
      name: fileName,
      bytes: Uint8List.fromList(bytes),
      parentId: parentId,
    );
  }

  /// Wrapper to create a FileNode from an existing blob.
  static Future<String?> createFileNode({
    required HttpClient client,
    required AccountId accountId,
    required String name,
    required String blobId,
    Id? parentId,
  }) {
    return _createFileNode(
      client: client,
      accountId: accountId,
      name: name,
      blobId: blobId,
      parentId: parentId,
    );
  }

  /// Creates a FileNode entry.
  static Future<String?> _createFileNode({
    required HttpClient client,
    required AccountId accountId,
    required String name,
    required String blobId,
    Id? parentId,
  }) async {
    final cid = Id("file-${DateTime.now().microsecondsSinceEpoch % 1000000}");
    final method = SetFileNodeMethod(accountId)
      ..create = {cid: FileNode(name: name, parentId: parentId, blobId: blobId)};
    final resp = await _executeSet(client, method);
    final created = resp.created?[cid];
    if (created == null || created.id == null) throw Exception(resp);
    return created.id!.value;
  }

  /// Executes FileNode/set.
  static Future<SetFileNodeResponse> _executeSet(
    HttpClient client,
    SetFileNodeMethod method, {
    MethodCallId? methodCallId,
  }) async {
    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method, methodCallId: methodCallId);
    final resp =
        await (builder..usings(method.requiredCapabilities)).build().execute();

    final parsed = resp.parse<SetFileNodeResponse>(
      inv.methodCallId,
      SetFileNodeResponse.deserialize,
    );

    if (parsed != null) return parsed;

    return SetFileNodeResponse.deserialize({
      "accountId": method.accountId.id.value,
      "oldState": null,
      "newState": null,
      "created": {},
      "updated": {},
      "destroyed": [],
      "notCreated": {},
      "notUpdated": {},
      "notDestroyed": {},
    });
  }

  /// Builds a full download URL using the server template.
  /// If the server template is missing, a default template is used.
  /// Replaces accountId, blobId, name, and type placeholders.
  static String buildDownloadUrl({
    required String baseUrl,
    required String? template,
    required String accountId,
    required String blobId,
    required String name,
  }) {
    String t = template ??
        '$baseUrl/download/{accountId}/{blobId}/{name}?accept={type}';
    t = Uri.decodeFull(t);

    return t
        .replaceAll('{accountId}', accountId)
        .replaceAll('{blobId}', blobId)
        .replaceAll('{name}', name)
        .replaceAll('{type}', '*/*');
  }

  /// Downloads a blob using the server download URL template.
  /// Returns the raw bytes of the blob.
  static Future<Uint8List> downloadBlobRaw({
    required Dio dio,
    required String downloadUrlTemplate,
    required String accountId,
    required String blobId,
    required String name,
    required String authorization,
  }) async {
    final url = buildDownloadUrl(
      baseUrl: dio.options.baseUrl,
      template: downloadUrlTemplate,
      accountId: accountId,
      blobId: blobId,
      name: name,
    );

    final resp = await dio.get<List<int>>(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        headers: {
          'Authorization': authorization,
          'Accept': '*/*',
        },
      ),
    );

    final data = resp.data;
    if (data == null) {
      throw Exception("No data returned for blob $blobId");
    }

    return Uint8List.fromList(data);
  }

  /// Copies a JMAP file into a local file.
  /// The local file will contain either text or binary data depending on the blob content.
  static Future<File> downloadToLocal({
    required HttpClient client,
    required AccountId accountId,
    required String jmapPath,
    required String localPath,
  }) async {
    final data = await downloadFile(
      client: client,
      accountId: accountId,
      jmapPath: jmapPath,
    );
    if (data is String) {
      return await File(localPath).writeAsString(data);
    }
    if (data is Uint8List) {
      return await File(localPath).writeAsBytes(data);
    }
    return Future.error("Unsupported data type");
  }

  /// Downloads a file by path.
  static Future<dynamic> downloadFile({
    required HttpClient client,
    required AccountId accountId,
    required String jmapPath,
  }) async {
    final all = await getFileNodes(client: client, accountId: accountId);
    final resolver = FileNodePathResolver(all.list);
    final node = resolver.resolve(jmapPath);
    if (node == null) {
      throw Exception("File not found $jmapPath");
    }
    if (node.blobId == null) {
      throw Exception("folder download is not supported yet");
    }
    return BlobUtil.getBlob(
      client: client,
      accountId: accountId,
      blobId: node.blobId!,
    );
  }

  /// Lists children of a folder.
  static Future<List<FileNode>> listFolder({
    required HttpClient client,
    required AccountId accountId,
    required String path,
  }) async {
    final all = await getFileNodes(client: client, accountId: accountId);
    final resolver = FileNodePathResolver(all.list);
    final folder = resolver.resolve(path);
    return resolver.listChildren(folder?.id?.value);
  }

  /// Lists all files.
  static Future<List<FileNode>> listAllFiles({
    required HttpClient client,
    required AccountId accountId,
  }) async {
    final resp = await getFileNodes(client: client, accountId: accountId);
    final files = <FileNode>[];
    for (final node in resp.list) {
      if (node.blobId != null) files.add(node);
    }
    return files;
  }

  /// Internal helper for GetFileNode calls.
  static Future<GetFileNodeResponse> _executeGet({
    required HttpClient client,
    required GetFileNodeMethod method,
  }) async {
    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method);

    final resp =
        await (builder..usings(method.requiredCapabilities)).build().execute();

    final parsed = resp.parse<GetFileNodeResponse>(
      inv.methodCallId,
      GetFileNodeResponse.deserialize,
    );

    if (parsed == null) {
      throw Exception("GetFileNodeResponse parse failure");
    }

    return parsed;
  }

  /// Fetches all FileNode items.
  static Future<GetFileNodeResponse> getFileNodes({
    required HttpClient client,
    required AccountId accountId,
  }) {
    final method = GetFileNodeMethod(accountId)
      ..properties = Properties({
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
        "shareWith",
      });

    return _executeGet(client: client, method: method);
  }

  /// Fetches a FileNode by id.
  static Future<FileNode?> getFileNodeById({
    required HttpClient client,
    required AccountId accountId,
    required String id,
  }) async {
    final method = GetFileNodeMethod(accountId)
      ..ids = {Id(id)}
      ..properties = Properties({
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
        "shareWith",
      });

    final resp = await _executeGet(client: client, method: method);
    if (resp.list.isEmpty) return null;
    return resp.list.first;
  }

  /// Sends FileNode/changes.
  static Future<ChangesFileNodeResponse> changesFileNodes({
    required HttpClient client,
    required AccountId accountId,
    required State sinceState,
    UnsignedInt? maxChanges,
    MethodCallId? methodCallId,
  }) async {
    final method =
        ChangesFileNodeMethod(accountId, sinceState, maxChanges: maxChanges);
    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method, methodCallId: methodCallId);
    final resp =
        await (builder..usings(method.requiredCapabilities)).build().execute();
    final parsed = resp.parse<ChangesFileNodeResponse>(
      inv.methodCallId,
      ChangesFileNodeResponse.deserialize,
    );
    if (parsed == null) throw Exception("ChangesFileNodeResponse parse failure");
    return parsed;
  }

  /// Returns all file nodes that are folders.
  /// A node is considered a folder if it does not have a blobId.
  static Future<List<FileNode>> listAllFolders({
    required HttpClient client,
    required AccountId accountId,
  }) async {
    final resp = await getFileNodes(client: client, accountId: accountId);
    final folders = <FileNode>[];
    for (final node in resp.list) {
      if (node.blobId == null) folders.add(node);
    }
    return folders;
  }

  //Handles String, Uint8List, and List<int>
  static Future<void> writeDownloadedData({
    required Object data,
    required String localPath,
  }) async {
    final file = File(localPath);

    if (data is String) {
      await file.writeAsString(data);
      return;
    }

    if (data is Uint8List) {
      await file.writeAsBytes(data);
      return;
    }

    if (data is List<int>) {
      await file.writeAsBytes(data);
      return;
    }

    throw UnsupportedError(
      'Unsupported downloaded data type: ${data.runtimeType}',
    );
  }
}
