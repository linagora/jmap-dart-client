import 'package:equatable/equatable.dart';

class CalendarAttendeeName with EquatableMixin {
  final String name;

  CalendarAttendeeName(this.name);

  @override
  List<Object?> get props => [name];
}