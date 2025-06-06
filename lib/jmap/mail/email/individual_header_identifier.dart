import 'package:equatable/equatable.dart';

class IndividualHeaderIdentifier with EquatableMixin {
  static final headerUserAgent = IndividualHeaderIdentifier('header:User-Agent:asText');
  static final headerMdn = IndividualHeaderIdentifier('header:Disposition-Notification-To:asText');
  static final headerReturnPath = IndividualHeaderIdentifier('header:Return-Path:asText');
  static final headerCalendarEvent = IndividualHeaderIdentifier('header:X-MEETING-UID:asText');
  static final acceptLanguageHeader = IndividualHeaderIdentifier('header:Accept-Language:asText');
  static final contentLanguageHeader = IndividualHeaderIdentifier('header:Content-Language:asText');
  static final sMimeStatusHeader = IndividualHeaderIdentifier('header:X-SMIME-Status:asText');
  static final identityHeader = IndividualHeaderIdentifier('header:X-JMAP-Identity:asText');
  static final xPriorityHeader = IndividualHeaderIdentifier('header:X-Priority:asText');
  static final priorityHeader = IndividualHeaderIdentifier('header:Priority:asText');
  static final importanceHeader = IndividualHeaderIdentifier('header:Importance:asText');
  static final listPostHeader = IndividualHeaderIdentifier('header:List-Post:asText');
  static final listUnsubscribeHeader = IndividualHeaderIdentifier('header:List-Unsubscribe:asText');

  final String value;

  IndividualHeaderIdentifier(this.value);

  @override
  List<Object> get props => [value];
}