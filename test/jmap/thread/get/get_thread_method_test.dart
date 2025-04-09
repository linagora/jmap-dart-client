import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:jmap_dart_client/jmap/thread/get/get_thread_method.dart';
import 'package:jmap_dart_client/jmap/thread/get/get_thread_response.dart';
import 'package:jmap_dart_client/jmap/thread/thread.dart';

void main() {
  final baseOption = BaseOptions(method: 'POST');
  final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
  final dioAdapter = DioAdapter(dio: dio);
  final dioAdapterHeaders = {"accept": "application/json;jmapVersion=rfc-8621"};
  final httpClient = HttpClient(dio);
  final processingInvocation = ProcessingInvocation();
  final requestBuilder = JmapRequestBuilder(httpClient, processingInvocation);
  final accountId = AccountId(Id('123abc'));
  final foundThreadId = ThreadId(Id('found-thread-id'));
  final emailIdFound = EmailId(Id('email-id-found'));
  final foundThread = Thread(id: foundThreadId, emailIds: [emailIdFound]);
  final notFoundThreadId = ThreadId(Id('not-found-thread-id'));
  final getThreadMethod = GetThreadMethod(
    accountId,
    [foundThreadId, notFoundThreadId],
  );
  final methodCallId = MethodCallId('c0');

  group('get thread method test:', () {
    test(
      'should return list email id '
      'when thread found '
      'and return not found '
      'when thread not found',
    () async {
      // arrange
      final sampleRequest = {
        "using": getThreadMethod.requiredCapabilities
          .map((capability) => capability.value.toString())
          .toList(),
        "methodCalls": [
          [
            getThreadMethod.methodName.value,
            {
              "accountId": accountId.id.value,
              "ids": getThreadMethod.ids.map((e) => e.id.value).toList(),
            },
            methodCallId.value
          ]
        ]
      };
      final sampleResponse = {
        "sessionState": "abcdefghij",
        "methodResponses": [
          [
            getThreadMethod.methodName.value,
            {
              "accountId": accountId.id.value,
              "state": "state",
              "list": [foundThread.toJson()],
              "notFound": [notFoundThreadId.id.value],
            },
            methodCallId.value,
          ]
        ]
      };
      dioAdapter.onPost(
        '',
        (server) => server.reply(200, sampleResponse),
        data: sampleRequest,
        headers: dioAdapterHeaders
      );
      
      // act
      final invocation = requestBuilder.invocation(
        getThreadMethod,
        methodCallId: methodCallId,
      );
      final response = (await (requestBuilder..usings(getThreadMethod.requiredCapabilities))
        .build()
        .execute())
        .parse(invocation.methodCallId, GetThreadResponse.deserialize);
      
      // assert
      expect(
        response,
        equals(GetThreadResponse(
          accountId,
          State('state'),
          [foundThread],
          [notFoundThreadId.id],
        )),
      );
    });
  });
}