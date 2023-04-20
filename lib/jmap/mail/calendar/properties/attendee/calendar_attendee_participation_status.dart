import 'package:equatable/equatable.dart';

class CalendarAttendeeParticipationStatus with EquatableMixin {
  static final needsAction = CalendarAttendeeParticipationStatus('needs-action');
  static final accepted = CalendarAttendeeParticipationStatus('accepted');
  static final declined = CalendarAttendeeParticipationStatus('declined');
  static final tentative = CalendarAttendeeParticipationStatus('tentative');
  static final delegated = CalendarAttendeeParticipationStatus('delegated');
  static final completed = CalendarAttendeeParticipationStatus('completed');
  static final inProcess = CalendarAttendeeParticipationStatus('in-process');

  final String value;

  CalendarAttendeeParticipationStatus(this.value);

  @override
  List<Object?> get props => [value];
}