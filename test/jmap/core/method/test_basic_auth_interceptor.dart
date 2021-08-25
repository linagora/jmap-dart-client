import 'dart:convert';

import 'package:dio/dio.dart';

class TestBasicAuthInterceptor extends InterceptorsWrapper {
  final String username;
  final String password;

  TestBasicAuthInterceptor(this.username, this.password);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    super.onRequest(options, handler);
  }
}