import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/properties_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/get_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/request/result_reference.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_calendar_event_method.g.dart';

@IdConverter()
@AccountIdConverter()
@PropertiesConverter()
@JsonSerializable()
class GetCalendarEventMethod extends GetMethod {
  GetCalendarEventMethod(AccountId accountId) : super(accountId);

  @override
  MethodName get methodName => MethodName('CalendarEvent/get');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities =>
      {CapabilityIdentifier.jmapCore, CapabilityIdentifier.jmapCalendarEvent};

  @override
  List<Object?> get props =>
      [methodName, accountId, ids, properties, requiredCapabilities];

  factory GetCalendarEventMethod.fromJson(Map<String, dynamic> json) =>
      _$GetCalendarEventMethodFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GetCalendarEventMethodToJson(this);
}
