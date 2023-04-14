import 'package:equatable/equatable.dart';

class CapabilityIdentifier with EquatableMixin {
  static final jmapCore = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:core'));
  static final jmapMail = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:mail'));
  static final jmapSubmission = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:submission'));
  static final jmapVacationResponse = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:vacationresponse'));
  static final jmapWebSocket = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:websocket'));
  static final jmapMdn = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:mdn'));
  static final jmapQuota = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:quota'));
  static final jmapTeamMailboxes = CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:shares'));
  static final jamesSortOrder = CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:identity:sortorder'));
  static final calendarEvent = CapabilityIdentifier(Uri.parse('com:linagora:params:calendar:event'));

  final Uri value;

  CapabilityIdentifier(this.value);

  @override
  List<Object> get props => [value];
}
