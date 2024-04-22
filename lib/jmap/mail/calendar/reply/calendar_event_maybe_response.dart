import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/calendar_event_reply_response.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/event_id.dart';
import 'package:jmap_dart_client/util/json_parsers.dart';

class CalendarEventMaybeResponse extends CalendarEventReplyResponse {
  CalendarEventMaybeResponse(
    super.accountId,
    super.notFound,
    {
      this.maybe,
      this.notMaybe
    });

  final List<EventId>? maybe;
  final List<Id>? notMaybe;

  static CalendarEventMaybeResponse deserialize(Map<String, dynamic> json) {
    return CalendarEventMaybeResponse(
      JsonParsers().parsingAccountId(json),
      JsonParsers().parsingListId(json, 'notFound'),
      maybe: JsonParsers().parsingListEventId(json, 'maybe'),
      notMaybe: JsonParsers().parsingListId(json, 'notMaybe'),
    );
  }

  @override
  List<Object?> get props => [...super.props, maybe, notMaybe];
}