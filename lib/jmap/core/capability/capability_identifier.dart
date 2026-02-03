import 'package:equatable/equatable.dart';

class CapabilityIdentifier with EquatableMixin {
  static final jmapCore = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:core'));
  static final jmapMail = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:mail'));
  static final jmapSubmission = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:submission'));
  static final jmapVacationResponse = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:vacationresponse'));
  static final jmapWebSocket = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:websocket'));

  static final jmapWebSocketTicket = CapabilityIdentifier(Uri.parse('com:linagora:params:jmap:ws:ticket'));
  static final jmapMdn = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:mdn'));
  static final jmapQuota = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:quota'));
  static final jmapTeamMailboxes = CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:shares'));
  static final jamesSortOrder = CapabilityIdentifier(Uri.parse('urn:apache:james:params:jmap:mail:identity:sortorder'));
  static final jmapCalendarEvent = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:calendars'));
  static final jmapCard = CapabilityIdentifier(Uri.parse('https://www.audriga.eu/jmap/jscontact/'));
  static final jmapContactCard = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:contacts'));
  static final jmapCyrusContact = CapabilityIdentifier(Uri.parse('https://cyrusimap.org/ns/jmap/contacts'));
  static final jamesCalendarEvent = CapabilityIdentifier(Uri.parse('com:linagora:params:calendar:event'));
  static final jmapPublicAsset = CapabilityIdentifier(Uri.parse('com:linagora:params:jmap:public:assets'));
  static final jmapMailboxClear = CapabilityIdentifier(Uri.parse('com:linagora:params:jmap:mailbox:clear'));
  static final jmapFileNode = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:filenode'));
  static final jmapBlob = CapabilityIdentifier(Uri.parse('urn:ietf:params:jmap:blob'));


  final Uri value;

  CapabilityIdentifier(this.value);

  @override
  List<Object> get props => [value];
}
