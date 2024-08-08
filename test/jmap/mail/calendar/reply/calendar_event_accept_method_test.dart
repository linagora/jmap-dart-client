import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/request/calendar_event_reply_method.dart';
import 'package:jmap_dart_client/jmap/core/method/response/calendar_event_reply_response.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/event_id.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/reply/calendar_event_accept_method.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/reply/calendar_event_accept_response.dart';

void main() {
  final baseOption = BaseOptions(method: 'POST');
  final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
  final dioAdapter = DioAdapter(dio: dio);
  final dioAdapterHeaders = {"accept": "application/json;jmapVersion=rfc-8621"};
  final httpClient = HttpClient(dio);
  final processingInvocation = ProcessingInvocation();
  final requestBuilder = JmapRequestBuilder(httpClient, processingInvocation);
  final accountId = AccountId(Id('123abc'));
  final successBlobId = Id('abc123');
  final failureBlobId = Id('def456');
  final notFoundBlobId = Id('ghi789');
  final blobIds = [successBlobId, failureBlobId, notFoundBlobId];
  final methodCallId = MethodCallId('c0');

  Map<String, dynamic> constructData(CalendarEventReplyMethod method) => {
    "using": method.requiredCapabilities
      .map((capability) => capability.value.toString())
      .toList(),
    "methodCalls": [
      [
        method.methodName.value,
        {
          "accountId": accountId.id.value,
          "blobIds": blobIds.map((id) => id.value).toList(),
        },
        methodCallId.value
      ]
    ]
  };

  Map<String, dynamic> constructResponse(CalendarEventReplyMethod method) => {
    "sessionState": "abcdefghij",
    "methodResponses": [[
      method.methodName.value,
      {
        "accountId": accountId.id.value,
        "accepted": [successBlobId.value],
        "notCreated": [failureBlobId.value],
        "notFound": [notFoundBlobId.value],
      },
      methodCallId.value
    ]]
  };

  group('calendar event accept method', () {
    final method = CalendarEventAcceptMethod(accountId, blobIds: blobIds);

    test('should succeed with success blob data, '
    'and fail with failure blob data '
    'and not found with not found blob data', () async {
      // arrange
      final invocation = requestBuilder.invocation(method, methodCallId: methodCallId);
      dioAdapter.onPost(
        '',
        (server) => server.reply(200, constructResponse(method)),
        data: constructData(method),
        headers: dioAdapterHeaders,
      );

      // act
      final response = (await (requestBuilder..usings(method.requiredCapabilities))
        .build()
        .execute())
          .parse<CalendarEventReplyResponse>(
            invocation.methodCallId,
            CalendarEventAcceptResponse.deserialize);
      
      // assert
      expect((response as CalendarEventAcceptResponse?)?.accepted, equals([EventId(successBlobId.value)]));
      expect(response?.notCreated, equals([failureBlobId]));
      expect(response?.notFound, equals([notFoundBlobId]));
    });
  });
}