import 'package:jmap_dart_client/jmap/core/error/set_error.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/calendar_event_reply_response.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/event_id.dart';
import 'package:jmap_dart_client/util/json_parsers.dart';

class CalendarEventRejectResponse extends CalendarEventReplyResponse {
  CalendarEventRejectResponse(
    super.accountId,
    super.notFound,
    {
      this.rejected,
      this.notRejected
    });

  final List<EventId>? rejected;
  final Map<Id, SetError>? notRejected;

  static CalendarEventRejectResponse deserialize(Map<String, dynamic> json) {
    return CalendarEventRejectResponse(
      JsonParsers().parsingAccountId(json),
      JsonParsers().parsingListId(json, 'notFound'),
      rejected: JsonParsers().parsingListEventId(json, 'rejected'),
      notRejected: JsonParsers().parsingMapSetError(json, 'notRejected'),
    );
  }

  @override
  List<Object?> get props => [...super.props, rejected, notRejected];
}