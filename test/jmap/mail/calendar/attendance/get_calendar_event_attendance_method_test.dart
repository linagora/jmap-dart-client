import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/error/method/exception/error_method_response_exception.dart';
import 'package:jmap_dart_client/jmap/core/error/set_error.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/attendance/calendar_event_attendance.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/attendance/get_calendar_event_attendance_method.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/attendance/get_calendar_event_attendance_response.dart';

void main() {
  group('get calendar event attendance method test', () {
    final baseOption = BaseOptions(method: 'POST');
    final dio = Dio(baseOption)..options.baseUrl = 'http://domain.com/jmap';
    final dioAdapter = DioAdapter(dio: dio);
    final dioAdapterHeaders = {"accept": "application/json;jmapVersion=rfc-8621"};
    final httpClient = HttpClient(dio);
    final processingInvocation = ProcessingInvocation();
    final requestBuilder = JmapRequestBuilder(httpClient, processingInvocation);
    final accountId = AccountId(Id('123abc'));
    final freeBlobId = Id('abc123');
    final busyBlobId = Id('def456');
    final notFoundBlobId = Id('ghi789');
    
    final methodCallId = MethodCallId('c0');

    test(
      'should return CalendarEventAttendance '
      'when the method returns success',
    () async {
      // arrange
      final freeAttendance = CalendarEventAttendance(
        blobId: freeBlobId,
        eventAttendanceStatus: AttendanceStatus.accepted,
        isFree: true,
      );
      final busyAttendance = CalendarEventAttendance(
        blobId: busyBlobId,
        eventAttendanceStatus: AttendanceStatus.rejected,
        isFree: false,
      );
      final blobIds = [freeBlobId, busyBlobId, notFoundBlobId];
      final getCalendarEventAttendanceMethod = GetCalendarEventAttendanceMethod(accountId, blobIds);
      final invocation = requestBuilder.invocation(
        getCalendarEventAttendanceMethod,
        methodCallId: methodCallId,
      );

      final sampleRequest = {
        "using": getCalendarEventAttendanceMethod.requiredCapabilities
            .map((capability) => capability.value.toString())
            .toList(),
        "methodCalls": [
          [
            getCalendarEventAttendanceMethod.methodName.value,
            {
              "accountId": accountId.id.value,
              "blobIds": blobIds.map((id) => id.value).toList(),
            },
            methodCallId.value
          ]
        ]
      };
      final sampleResponse = {
        "sessionState": "abcdefghij",
        "methodResponses": [
          [
            "CalendarEventAttendance/get",
            {
              "accountId": accountId.id.value,
              "state": "state",
              "list": [freeAttendance.toJson(), busyAttendance.toJson()],
              "notFound": [notFoundBlobId.value],
              "notDone": {},
            },
            methodCallId.value
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
      final response = (await (requestBuilder..usings(getCalendarEventAttendanceMethod.requiredCapabilities))
        .build()
        .execute())
        .parse<GetCalendarEventAttendanceResponse>(
          invocation.methodCallId,
          GetCalendarEventAttendanceResponse.deserialize);

      // assert
      expect(response?.accountId, equals(accountId));
      expect(response?.list, equals([freeAttendance, busyAttendance]));
      expect(response?.notFound, equals([notFoundBlobId]));
      expect(response?.notDone?.isEmpty, isTrue);
    });

    test(
      'should return notDone '
      'when blobId is invalid',
    () async {
      // arrange
      final blobId = Id('invalid');
      final getCalendarEventAttendanceMethod = GetCalendarEventAttendanceMethod(accountId, [blobId]);
      final invocation = requestBuilder.invocation(
        getCalendarEventAttendanceMethod,
        methodCallId: methodCallId,
      );

      final sampleRequest = {
        "using": getCalendarEventAttendanceMethod.requiredCapabilities
            .map((capability) => capability.value.toString())
            .toList(),
        "methodCalls": [
          [
            getCalendarEventAttendanceMethod.methodName.value,
            {
              "accountId": accountId.id.value,
              "blobIds": [blobId.value],
            },
            methodCallId.value
          ]
        ]
      };
      final sampleResponse = {
        "sessionState": "abcdefghij",
        "methodResponses": [
          [
            "CalendarEventAttendance/get",
            {
              "accountId": accountId.id.value,
              "state": "state",
              "list": [],
              "notFound": [],
              "notDone": {
                blobId.value: SetError(
                  SetError.invalidArguments,
                ).toJson(),
              },
            },
            methodCallId.value
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
      final response = (await (requestBuilder..usings(getCalendarEventAttendanceMethod.requiredCapabilities))
        .build()
        .execute())
        .parse<GetCalendarEventAttendanceResponse>(
          invocation.methodCallId,
          GetCalendarEventAttendanceResponse.deserialize);

      // assert
      expect(response?.accountId, equals(accountId));
      expect(response?.list.isEmpty, isTrue);
      expect(response?.notFound?.isEmpty, isTrue);
      expect(response?.notDone?[blobId], equals(SetError(SetError.invalidArguments)));
    });

    test(
      'should return error '
      'when method returns error',
    () async {
      // arrange
      final blobId = Id('invalid');
      final getCalendarEventAttendanceMethod = GetCalendarEventAttendanceMethod(accountId, [blobId]);
      final invocation = requestBuilder.invocation(
        getCalendarEventAttendanceMethod,
        methodCallId: methodCallId,
      );

      final sampleRequest = {
        "using": getCalendarEventAttendanceMethod.requiredCapabilities
            .map((capability) => capability.value.toString())
            .toList(),
        "methodCalls": [
          [
            getCalendarEventAttendanceMethod.methodName.value,
            {
              "accountId": accountId.id.value,
              "blobIds": [blobId.value],
            },
            methodCallId.value
          ]
        ]
      };
      final sampleResponse = {
        "sessionState": "abcdefghij",
        "methodResponses": [
          [
            "error",
            {
              "type": SetError.tooLarge.value,
            },
            methodCallId.value
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
      final response = (await (requestBuilder..usings(getCalendarEventAttendanceMethod.requiredCapabilities))
        .build()
        .execute());

      // assert
      expect(
        () => response.parse<GetCalendarEventAttendanceResponse>(
          invocation.methodCallId,
          GetCalendarEventAttendanceResponse.deserialize),
        throwsA(isA<ErrorMethodResponseException>()),
      );
    });
  });
}