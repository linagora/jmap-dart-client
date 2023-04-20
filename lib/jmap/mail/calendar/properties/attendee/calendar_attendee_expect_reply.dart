import 'package:equatable/equatable.dart';

class CalendarAttendeeExpectReply with EquatableMixin {

  final bool value;

  CalendarAttendeeExpectReply(this.value);

  @override
  List<Object?> get props => [value];
}