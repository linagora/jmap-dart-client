import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/set_error_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/jmap/core/error/set_error.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/method_response.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/attendance/calendar_event_attendance.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_calendar_event_attendance_response.g.dart';

@JsonSerializable(
  includeIfNull: false,
  createToJson: false,
  converters: [
    StateConverter(),
    AccountIdConverter(),
    IdConverter(),
    SetErrorConverter(),
  ],
)
class GetCalendarEventAttendanceResponse extends ResponseRequiringAccountId {
  GetCalendarEventAttendanceResponse(
    super.accountId,
    this.list,
    this.notFound,
    this.notDone,
  );

  final List<CalendarEventAttendance> list;
  final List<Id>? notFound;
  final Map<Id, SetError>? notDone;

  @override
  List<Object?> get props => [accountId, list, notFound, notDone];

  static GetCalendarEventAttendanceResponse deserialize(
    Map<String, dynamic> json,
  ) => _$GetCalendarEventAttendanceResponseFromJson(json);
}
