import 'package:equatable/equatable.dart';

class CalendarSequence with EquatableMixin {

  final int value;

  CalendarSequence(this.value);

  @override
  List<Object?> get props => [value];
}