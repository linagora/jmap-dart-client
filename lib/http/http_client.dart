import 'package:dio/dio.dart';

class HttpClient {
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
    return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress)
      .then((value) => value.data)
      .catchError((error) => throw error);
  }
}