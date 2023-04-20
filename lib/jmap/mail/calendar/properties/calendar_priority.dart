import 'package:equatable/equatable.dart';

class CalendarPriority with EquatableMixin {

  final int value;

  CalendarPriority(this.value);

  @override
  List<Object?> get props => [value];
}