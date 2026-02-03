import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/calendar/calendar.dart';
import 'package:jmap_dart_client/jmap/calendar/changes/changes_calendar_method.dart';
import 'package:jmap_dart_client/jmap/calendar/changes/changes_calendar_response.dart';
import 'package:jmap_dart_client/jmap/calendar/get/get_calendar_method.dart';
import 'package:jmap_dart_client/jmap/calendar/get/get_calendar_response.dart';
import 'package:jmap_dart_client/jmap/calendar/set/set_calendar_method.dart';
import 'package:jmap_dart_client/jmap/calendar/set/set_calendar_response.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';

class CalendarUtil {
  CalendarUtil._();

  static Future<SetCalendarResponse> setCalendars({
    required HttpClient client,
    required AccountId accountId,
    Map<Id, Calendar>? create,
    Map<Id, PatchObject>? update,
    Set<Id>? destroy,
    MethodCallId? methodCallId,
  }) async {
    final method = SetCalendarMethod(accountId);

    if (create != null && create.isNotEmpty) {
      method.addCreates(create);
    }
    if (update != null && update.isNotEmpty) {
      method.addUpdates(update);
    }
    if (destroy != null && destroy.isNotEmpty) {
      method.addDestroy(destroy);
    }

    return _executeSet(client, method, methodCallId: methodCallId);
  }

  static Future<GetCalendarResponse> getCalendars({
    required HttpClient client,
    required AccountId accountId,
  }) async {
    final method = GetCalendarMethod(accountId);
    return _executeGet(client: client, method: method);
  }

  static Future<Calendar?> getCalendarById({
    required HttpClient client,
    required AccountId accountId,
    required String id,
  }) async {
    final method = GetCalendarMethod(accountId)..ids = {Id(id)};

    final resp = await _executeGet(client: client, method: method);
    if (resp.list.isEmpty) {
      return null;
    }
    return resp.list.first;
  }

  static Future<ChangesCalendarResponse> changesCalendars({
    required HttpClient client,
    required AccountId accountId,
    required State sinceState,
    UnsignedInt? maxChanges,
    MethodCallId? methodCallId,
  }) async {
    final method = ChangesCalendarMethod(
      accountId,
      sinceState,
      maxChanges: maxChanges,
    );

    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method, methodCallId: methodCallId);

    final resp =
        await (builder..usings(method.requiredCapabilities)).build().execute();

    final parsed = resp.parse<ChangesCalendarResponse>(
      inv.methodCallId,
      ChangesCalendarResponse.deserialize,
    );

    if (parsed == null) {
      throw Exception(resp.toString());
    }

    return parsed;
  }

  static Future<SetCalendarResponse> createCalendar({
    required HttpClient client,
    required AccountId accountId,
    required Calendar calendar,
  }) async {
    final cid = Id('calendar-${DateTime.now().millisecondsSinceEpoch % 1000000}');
    final method = SetCalendarMethod(accountId)..addCreate(cid, calendar);
    return _executeSet(client, method);
  }

  static Future<SetCalendarResponse> updateCalendar({
    required HttpClient client,
    required AccountId accountId,
    required Id id,
    required PatchObject patch,
  }) async {
    final method = SetCalendarMethod(accountId)..addUpdates({id: patch});
    return _executeSet(client, method);
  }

  static Future<SetCalendarResponse> deleteCalendar({
    required HttpClient client,
    required AccountId accountId,
    required Id id,
  }) async {
    final method = SetCalendarMethod(accountId)..addDestroy({id});
    return _executeSet(client, method);
  }

  static Future<GetCalendarResponse> _executeGet({
    required HttpClient client,
    required GetCalendarMethod method,
  }) async {
    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method);

    final resp =
        await (builder..usings(method.requiredCapabilities)).build().execute();

    final parsed = resp.parse<GetCalendarResponse>(
      inv.methodCallId,
      GetCalendarResponse.deserialize,
    );

    if (parsed == null) {
      throw Exception(resp.toString());
    }

    return parsed;
  }

  static Future<SetCalendarResponse> _executeSet(
    HttpClient client,
    SetCalendarMethod method, {
    MethodCallId? methodCallId,
  }) async {
    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method, methodCallId: methodCallId);

    final resp =
        await (builder..usings(method.requiredCapabilities)).build().execute();
    final parsed = resp.parse<SetCalendarResponse>(
      inv.methodCallId,
      SetCalendarResponse.deserialize,
    );

    if (parsed == null) {
      throw Exception(resp.toString());
    }

    return parsed;
  }
}
