
import 'package:equatable/equatable.dart';

class CalendarAttendeeKind with EquatableMixin {
  static final individual = CalendarAttendeeKind('individual');
  static final group = CalendarAttendeeKind('group');
  static final resource = CalendarAttendeeKind('resource');
  static final room = CalendarAttendeeKind('room');
  static final unknown = CalendarAttendeeKind('unknown');

  final String value;

  CalendarAttendeeKind(this.value);

  @override
  List<Object?> get props => [value];
}