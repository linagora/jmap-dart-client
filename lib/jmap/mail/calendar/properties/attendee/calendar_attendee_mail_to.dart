
import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/mail/calendar/properties/mail_address.dart';

class CalendarAttendeeMailTo with EquatableMixin {
  final MailAddress mailAddress;

  CalendarAttendeeMailTo(this.mailAddress);

  @override
  List<Object?> get props => [mailAddress];
}