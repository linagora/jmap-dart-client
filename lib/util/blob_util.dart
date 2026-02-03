import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/blob/blob.dart';
import 'package:jmap_dart_client/jmap/blob/get/get_blob_method.dart';
import 'package:jmap_dart_client/jmap/blob/get/get_blob_response.dart';
import 'package:jmap_dart_client/jmap/blob/upload/upload_blob_method.dart';
import 'package:jmap_dart_client/jmap/blob/upload/upload_blob_response.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/properties/properties.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';

class BlobUtil {
  BlobUtil._();

  /// Uploads text content as a blob.
  static Future<Blob?> uploadBlobFromText({
    required HttpClient client,
    required AccountId accountId,
    required String content,
    Id? clientId,
  }) async {
    final blob = Blob(
      data: [
        {"data:asText": content}
      ],
    );

    final cid =
        clientId ?? Id('blob-${DateTime.now().microsecondsSinceEpoch % 1000000}');

    final result = await uploadMultipart(
      client: client,
      accountId: accountId,
      blobs: {cid: blob},
    );

    return result[cid];
  }

  /// Uploads binary content as a blob.
  static Future<Blob?> uploadBlobFromBytes({
    required HttpClient client,
    required AccountId accountId,
    required Uint8List content,
    Id? clientId,
  }) async {
    final blob = Blob(
      data: [
        {"data:asBase64": base64Encode(content)}
      ],
    );

    final cid =
        clientId ?? Id('blob-${DateTime.now().microsecondsSinceEpoch % 1000000}');

    final result = await uploadMultipart(
      client: client,
      accountId: accountId,
      blobs: {cid: blob},
    );

    return result[cid];
  }

  /// Uploads a blob from a file on disk.
  static Future<Blob?> uploadBlobFromFile({
    required HttpClient client,
    required AccountId accountId,
    required File file,
    Id? clientId,
  }) async {
    final bytes = await file.readAsBytes();

    return uploadBlobFromBytes(
      client: client,
      accountId: accountId,
      content: Uint8List.fromList(bytes),
      clientId: clientId,
    );
  }

  /// Uploads multiple blobs in a single JMAP request.
  static Future<Map<Id, Blob>> uploadMultipart({
    required HttpClient client,
    required AccountId accountId,
    required Map<Id, Blob> blobs,
  }) async {
    final builder = JmapRequestBuilder(client, ProcessingInvocation());

    for (final entry in blobs.entries) {
      final method = UploadBlobMethod(accountId)
        ..addCreate(entry.key, entry.value);

      builder.invocation(method);
      builder.usings(method.requiredCapabilities);
    }

    final resp = await builder.build().execute();
    final result = <Id, Blob>{};

    for (final mr in resp.methodResponses) {
      if (mr.methodName == MethodName('Blob/upload')) {
        final parsed =
            UploadBlobResponse.deserialize(mr.arguments.value);

        if (parsed.created != null) {
          result.addAll(parsed.created!);
        }
      }
    }

    return result;
  }

  /// Fetches a blob by id and returns text or binary content.
  static Future<dynamic> getBlob({
    required HttpClient client,
    required AccountId accountId,
    required String blobId,
  }) async {
    final method = GetBlobMethod(accountId)
      ..ids = {Id(blobId)}
      ..properties = Properties({
        "data:asText",
        "data:asBase64",
        "size",
        "type"
      });

    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method);

    final resp =
        await (builder..usings(method.requiredCapabilities)).build().execute();

    final parsed = resp.parse<GetBlobResponse>(
      inv.methodCallId,
      GetBlobResponse.deserialize,
    );

    if (parsed == null || parsed.list.isEmpty) {
      return null;
    }

    final blob = parsed.list.first;

    if (blob.dataAsText != null) {
      return blob.dataAsText;
    }

    if (blob.dataAsBase64 != null) {
      return Uint8List.fromList(base64Decode(blob.dataAsBase64!));
    }

    return null;
  }
}
