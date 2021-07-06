import 'package:equatable/equatable.dart';

class State with EquatableMixin {
  final String value;

  State(this.value);

  @override
  List<Object?> get props => [value];
}