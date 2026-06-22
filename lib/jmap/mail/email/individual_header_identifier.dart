import 'package:equatable/equatable.dart';

class IndividualHeaderIdentifier with EquatableMixin {
  static final headerUserAgent = IndividualHeaderIdentifier.asText('User-Agent');
  static final headerMdn = IndividualHeaderIdentifier.asText('Disposition-Notification-To');
  static final headerReturnPath = IndividualHeaderIdentifier.asText('Return-Path');
  static final headerCalendarEvent = IndividualHeaderIdentifier.asText('X-MEETING-UID');
  static final acceptLanguageHeader = IndividualHeaderIdentifier.asText('Accept-Language');
  static final contentLanguageHeader = IndividualHeaderIdentifier.asText('Content-Language');
  static final sMimeStatusHeader = IndividualHeaderIdentifier.asText('X-SMIME-Status');
  static final identityHeader = IndividualHeaderIdentifier.asText('X-JMAP-Identity');
  static final xPriorityHeader = IndividualHeaderIdentifier.asText('X-Priority');
  static final priorityHeader = IndividualHeaderIdentifier.asText('Priority');
  static final importanceHeader = IndividualHeaderIdentifier.asText('Importance');
  static final listPostHeader = IndividualHeaderIdentifier.asText('List-Post');
  static final listUnsubscribeHeader = IndividualHeaderIdentifier.asText('List-Unsubscribe');

  final String value;

  IndividualHeaderIdentifier(this.value);

  // Static factories — build 'header:Name:form' keys
  static IndividualHeaderIdentifier asText(String headerName)
      => IndividualHeaderIdentifier('header:$headerName:asText');

  static IndividualHeaderIdentifier asRaw(String headerName)
      => IndividualHeaderIdentifier('header:$headerName:asRaw');

  static IndividualHeaderIdentifier asDate(String headerName)
      => IndividualHeaderIdentifier('header:$headerName:asDate');

  static IndividualHeaderIdentifier asAddresses(String headerName)
      => IndividualHeaderIdentifier('header:$headerName:asAddresses');

  static IndividualHeaderIdentifier asMessageIds(String headerName)
      => IndividualHeaderIdentifier('header:$headerName:asMessageIds');

  static IndividualHeaderIdentifier asURLs(String headerName)
      => IndividualHeaderIdentifier('header:$headerName:asURLs');

  // Chains ':all' suffix — RFC 8621 form for all occurrences of the header
  IndividualHeaderIdentifier all() => IndividualHeaderIdentifier('$value:all');

  // Extracts the header name from the key string (e.g. 'header:User-Agent:asText' → 'User-Agent')
  String get headerName {
    final parts = value.split(':');
    return parts.length >= 2 ? parts[1] : value;
  }

  @override
  List<Object> get props => [value];
}