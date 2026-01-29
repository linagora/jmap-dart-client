import 'package:jmap_dart_client/http/converter/capabilities_converter.dart';
import 'package:jmap_dart_client/http/http_client.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_properties.dart';
import 'package:jmap_dart_client/jmap/core/session/session.dart';

class GetSession {
  final HttpClient _httpClient;
  final CapabilitiesConverter _capabilitiesConverter;
  final bool useWellKnown;
  GetSession(this._httpClient, this._capabilitiesConverter, this.useWellKnown);

  Future<Session> execute() async {
    final url = useWellKnown ? '/.well-known/jmap' : '';
    return await _httpClient.get(url).then((value) => extractData(value)).catchError((error) => throw error);
  }

  Session extractData(Map<String, dynamic> body) {
    return Session.fromJson(body, converter: _capabilitiesConverter);
  }
}

class GetSessionBuilder {
  final HttpClient _httpClient;
  final CapabilitiesConverter _capabilitiesConverter = CapabilitiesConverter();
  final bool useWellKnown;

  GetSessionBuilder(this._httpClient, {this.useWellKnown = true});

  void registerCapabilityConverter(Map<CapabilityIdentifier, CapabilityProperties Function(Map<String, dynamic>)> converters) {
    _capabilitiesConverter.addConverters(converters);
    _capabilitiesConverter.build();
  }

  GetSession build() {
    return GetSession(_httpClient, _capabilitiesConverter, useWellKnown);
  }
}
