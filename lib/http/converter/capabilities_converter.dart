import 'package:built_collection/built_collection.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_properties.dart';
import 'package:jmap_dart_client/jmap/core/capability/core_capability.dart';
import 'package:jmap_dart_client/jmap/core/capability/default_capability.dart';
import 'package:jmap_dart_client/jmap/core/capability/mail_capability.dart';
import 'package:jmap_dart_client/jmap/core/capability/mdn_capability.dart';
import 'package:jmap_dart_client/jmap/core/capability/submission_capability.dart';
import 'package:jmap_dart_client/jmap/core/capability/vacation_capability.dart';
import 'package:jmap_dart_client/jmap/core/capability/websocket_capability.dart';

class CapabilitiesConverter {
  static final defaultConverter = CapabilitiesConverter();

  BuiltMap<CapabilityIdentifier, CapabilityProperties Function(Map<String, dynamic>)>? mapCapabilitiesConverter;
  final _mapCapabilityConverterBuilder = MapBuilder<CapabilityIdentifier, CapabilityProperties Function(Map<String, dynamic>)>();

  CapabilitiesConverter() {
    _mapCapabilityConverterBuilder.addAll(
      {
        CapabilityIdentifier.jmapMail: MailCapability.deserialize,
        CapabilityIdentifier.jmapCore: CoreCapability.deserialize,
        CapabilityIdentifier.jmapSubmission: SubmissionCapability.deserialize,
        CapabilityIdentifier.jmapVacationResponse: VacationCapability.deserialize,
        CapabilityIdentifier.jmapWebSocket: WebSocketCapability.deserialize,
        CapabilityIdentifier.jmapMdn: MdnCapability.deserialize
      });
  }

  void addConverters(Map<CapabilityIdentifier, CapabilityProperties Function(Map<String, dynamic>)> converters) {
    _mapCapabilityConverterBuilder.addAll(converters);
  }

  void build() {
    mapCapabilitiesConverter = _mapCapabilityConverterBuilder.build();
  }

  BuiltMap<CapabilityIdentifier, Function>? getConverters() {
    return mapCapabilitiesConverter;
  }

  MapEntry<CapabilityIdentifier, CapabilityProperties> convert(String key, dynamic value) {
    if (mapCapabilitiesConverter == null) {
      build();
    }

    final identifier = CapabilityIdentifier(Uri.parse(key));
    if (mapCapabilitiesConverter!.containsKey(identifier)) {
      return MapEntry(identifier, mapCapabilitiesConverter![identifier]!.call(value));
    } else {
      return MapEntry(identifier, DefaultCapability(value));
    }
  }
}