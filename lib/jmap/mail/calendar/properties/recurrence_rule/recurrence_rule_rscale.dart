import 'package:equatable/equatable.dart';

class RecurrenceRuleRScale with EquatableMixin {

  final String value;

  RecurrenceRuleRScale(this.value);

  @override
  List<Object?> get props => [value];
}