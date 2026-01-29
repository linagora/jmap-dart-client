import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/get_response.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/calendar/calendar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_calendar_response.g.dart';

@StateConverter()
@AccountIdConverter()
@IdConverter()
@JsonSerializable()
class GetCalendarResponse extends GetResponse<Calendar> {
  GetCalendarResponse(
    AccountId accountId,
    State? state,
    List<Calendar>? list,
    List<Id>? notFound,
  ) : super(
          accountId,
          state ?? State(''),
          list ?? const <Calendar>[],
          notFound,
        );

  factory GetCalendarResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCalendarResponseFromJson(json);

  static GetCalendarResponse deserialize(Map<String, dynamic> json) {
    return GetCalendarResponse.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetCalendarResponseToJson(this);

  @override
  List<Object?> get props => [accountId, state, list, notFound];
}
