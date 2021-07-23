import 'package:equatable/equatable.dart';

class CapabilityIdentifier with EquatableMixin {
  static final jmapCore = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:core'));
  static final jmapMail = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:mail'));
  static final jmapSubmission = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:submission'));
  static final jmapVacationResponse = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:vacationresponse'));
  static final jmapWebSocket = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:websocket'));

  final Uri value;

  CapabilityIdentifier(this.value);

  @override
  List<Object> get props => [value];
}
