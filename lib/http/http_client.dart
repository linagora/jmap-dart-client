import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jmap_dart_client/util/options_extensions.dart';

class HttpClient {
  static const jmapHeader = 'application/json;jmapVersion=rfc-8621';

  final Dio _dio;

  HttpClient(this._dio);

  Future<Map<String, dynamic>> post(
    String path, {
      data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
    }
  ) async {
    final newOptions = options?.appendHeaders({HttpHeaders.acceptHeader : jmapHeader})
      ?? Options(headers: {HttpHeaders.acceptHeader : jmapHeader}) ;

    return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: newOptions,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress)
      .then((value) => value.data)
      .catchError((error) => throw error);
  }

  Future<dynamic> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress)
      .then((value) => value.data)
      .catchError((error) => throw error);
  }
}