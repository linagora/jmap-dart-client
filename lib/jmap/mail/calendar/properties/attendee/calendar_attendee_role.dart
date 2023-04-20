import 'package:equatable/equatable.dart';

class CalendarAttendeeRole with EquatableMixin {

  static final chair = CalendarAttendeeRole('chair');
  static final requestedParticipant = CalendarAttendeeRole('requested-participant');
  static final optionalParticipant = CalendarAttendeeRole('optional-participant');
  static final nonParticipant = CalendarAttendeeRole('non-participant');

  final String value;

  CalendarAttendeeRole(this.value);

  @override
  List<Object?> get props => [value];
}