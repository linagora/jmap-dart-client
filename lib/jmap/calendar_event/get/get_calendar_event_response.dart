import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/get_response.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/calendar_event/calendar_event.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_calendar_event_response.g.dart';

@StateConverter()
@AccountIdConverter()
@IdConverter()
@JsonSerializable()
class GetCalendarEventResponse extends GetResponse<CalendarEvent> {
  GetCalendarEventResponse(
    AccountId accountId,
    State? state,
    List<CalendarEvent>? list,
    List<Id>? notFound,
  ) : super(
          accountId,
          state ?? State(''),
          list ?? const <CalendarEvent>[],
          notFound,
        );

  factory GetCalendarEventResponse.fromJson(Map<String, dynamic> json) => _$GetCalendarEventResponseFromJson(json);

  static GetCalendarEventResponse deserialize(Map<String, dynamic> json) {
    return GetCalendarEventResponse.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetCalendarEventResponseToJson(this);

  @override
  List<Object?> get props => [accountId, state, list, notFound];
}
