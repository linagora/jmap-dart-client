import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/properties_converter.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/request/get_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/request/result_reference.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_calendar_event_attendance_method.g.dart';

@JsonSerializable(
  converters: [
    IdConverter(),
    AccountIdConverter(),
    PropertiesConverter(),
  ],
  explicitToJson: true,
)
class GetCalendarEventAttendanceMethod extends GetMethod {
  GetCalendarEventAttendanceMethod(super.accountId, this.blobIds);

  final List<Id> blobIds;

  @override
  MethodName get methodName => MethodName('CalendarEventAttendance/get');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
        CapabilityIdentifier.jmapCore,
        CapabilityIdentifier.jamesCalendarEvent,
      };

  @override
  List<Object?> get props => [accountId, blobIds, properties];

  factory GetCalendarEventAttendanceMethod.fromJson(
    Map<String, dynamic> json,
  ) => _$GetCalendarEventAttendanceMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
    _$GetCalendarEventAttendanceMethodToJson(this);
}
