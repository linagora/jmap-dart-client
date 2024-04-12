import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/calendar_event_reply_response.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/event_id.dart';
import 'package:jmap_dart_client/util/json_parsers.dart';

class CalendarEventAcceptResponse extends CalendarEventReplyResponse {
  CalendarEventAcceptResponse(
    super.accountId,
    super.notFound,
    {
      this.accepted,
      this.notCreated
    });

  final List<EventId>? accepted;
  final List<Id>? notCreated;

  static CalendarEventAcceptResponse deserialize(Map<String, dynamic> json) {
    return CalendarEventAcceptResponse(
      JsonParsers().parsingAccountId(json),
      JsonParsers().parsingListId(json, 'notFound'),
      accepted: JsonParsers().parsingListEventId(json, 'accepted'),
      notCreated: JsonParsers().parsingListId(json, 'notCreated'),
    );
  }

  @override
  List<Object?> get props => [...super.props, accepted, notCreated];
}