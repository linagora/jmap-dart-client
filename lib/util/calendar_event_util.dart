import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/calendar_event/calendar_event.dart';
import 'package:jmap_dart_client/jmap/calendar_event/changes/changes_calendar_event_method.dart';
import 'package:jmap_dart_client/jmap/calendar_event/changes/changes_calendar_event_response.dart';
import 'package:jmap_dart_client/jmap/calendar_event/get/get_calendar_event_method.dart';
import 'package:jmap_dart_client/jmap/calendar_event/get/get_calendar_event_response.dart';
import 'package:jmap_dart_client/jmap/calendar_event/set/set_calendar_event_method.dart';
import 'package:jmap_dart_client/jmap/calendar_event/set/set_calendar_event_response.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:jmap_dart_client/jmap/jmap_request.dart';

class CalendarEventUtil {
  CalendarEventUtil._();

  /// Sends create, update, or destroy operations for calendar events.
  static Future<SetCalendarEventResponse> setCalendarEvents({
    required HttpClient client,
    required AccountId accountId,
    Map<Id, CalendarEvent>? create,
    Map<Id, PatchObject>? update,
    Set<Id>? destroy,
    MethodCallId? methodCallId,
  }) async {
    final method = SetCalendarEventMethod(accountId);

    if (create != null && create.isNotEmpty) {
      method.addCreates(create);
    }
    if (update != null && update.isNotEmpty) {
      method.addUpdates(update);
    }
    if (destroy != null && destroy.isNotEmpty) {
      method.addDestroy(destroy);
    }

    return _executeSet(
      client,
      method,
      methodCallId: methodCallId,
    );
  }

  /// Fetches all calendar events.
  static Future<GetCalendarEventResponse> getCalendarEvents({
    required HttpClient client,
    required AccountId accountId,
  }) async {
    final method = GetCalendarEventMethod(accountId);
    return _executeGetCalendar(client: client, method: method);
  }

  /// Fetches one calendar event by its id.
  static Future<CalendarEvent?> getCalendarEventById({
    required HttpClient client,
    required AccountId accountId,
    required String id,
  }) async {
    final method = GetCalendarEventMethod(accountId)
      ..ids = {Id(id)};

    final resp = await _executeGetCalendar(
      client: client,
      method: method,
    );

    if (resp.list.isEmpty) {
      return null;
    }

    return resp.list.first;
  }

  /// Executes a GetCalendarEventMethod call and returns the parsed response.
  static Future<GetCalendarEventResponse> _executeGetCalendar({
    required HttpClient client,
    required GetCalendarEventMethod method,
  }) async {
    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method);

    final raw = await (builder..usings(method.requiredCapabilities))
        .build()
        .execute();

    final parsed = raw.parse<GetCalendarEventResponse>(
      inv.methodCallId,
      GetCalendarEventResponse.deserialize,
    );

    if (parsed == null) {
      throw Exception(raw.toString());
    }

    return parsed;
  }

  /// Sends a changes request for calendar events.
  static Future<ChangesCalendarEventResponse> changesCalendarEvents({
    required HttpClient client,
    required AccountId accountId,
    required State sinceState,
    UnsignedInt? maxChanges,
    MethodCallId? methodCallId,
  }) async {
    final method = ChangesCalendarEventMethod(
      accountId,
      sinceState,
      maxChanges: maxChanges,
    );

    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method, methodCallId: methodCallId);

    final resp =
        await (builder..usings(method.requiredCapabilities)).build().execute();

    final parsed = resp.parse<ChangesCalendarEventResponse>(
      inv.methodCallId,
      ChangesCalendarEventResponse.deserialize,
    );

    if (parsed == null) {
      throw Exception(resp.toString());
    }

    return parsed;
  }

  /// Creates a new calendar event.
  static Future<SetCalendarEventResponse> createCalendarEvent({
    required HttpClient client,
    required AccountId accountId,
    required CalendarEvent event,
  }) async {
    final cid = Id('calendar-${DateTime.now().millisecondsSinceEpoch % 1000000}');
    final method = SetCalendarEventMethod(accountId)..addCreate(cid, event);

    return _executeSet(client, method);
  }

  /// Updates a calendar event by applying a patch.
  static Future<SetCalendarEventResponse> updateCalendarEvent({
    required HttpClient client,
    required AccountId accountId,
    required Id id,
    required PatchObject patch,
  }) async {
    final method = SetCalendarEventMethod(accountId)
      ..addUpdates({id: patch});

    return _executeSet(client, method);
  }

  /// Deletes a calendar event.
  static Future<SetCalendarEventResponse> deleteCalendarEvent({
    required HttpClient client,
    required AccountId accountId,
    required Id id,
  }) async {
    final method = SetCalendarEventMethod(accountId)
      ..addDestroy({id});

    return _executeSet(client, method);
  }

  /// Internal helper for executing CalendarEvent/set.
  static Future<SetCalendarEventResponse> _executeSet(
    HttpClient client,
    SetCalendarEventMethod method, {
    MethodCallId? methodCallId,
  }) async {
    final builder = JmapRequestBuilder(client, ProcessingInvocation());
    final inv = builder.invocation(method, methodCallId: methodCallId);

    final resp =
        await (builder..usings(method.requiredCapabilities)).build().execute();

    final parsed = resp.parse<SetCalendarEventResponse>(
      inv.methodCallId,
      SetCalendarEventResponse.deserialize,
    );

    if (parsed == null) {
      throw Exception(resp.toString());
    }
    return parsed;
  }
}
