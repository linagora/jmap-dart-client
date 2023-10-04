import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/properties_converter.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/method/request/parse_method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/calendar_event.dart';

class CalendarEventParseMethod extends ParseMethod<CalendarEvent> {

  CalendarEventParseMethod(super.accountId, super.blobIds);

  @override
  MethodName get methodName => MethodName('CalendarEvent/parse');

  @override
  Set<CapabilityIdentifier> get requiredCapabilities => {
    CapabilityIdentifier.jmapCore,
    CapabilityIdentifier.jamesCalendarEvent
  };

  @override
  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(accountId),
      'blobIds': blobIds.map(const IdConverter().toJson).toList()
    };

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('properties', const PropertiesConverter().toJson(properties));

    return val;
  }

  @override
  List<Object?> get props => [accountId, blobIds, properties];
}
