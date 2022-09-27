import 'package:equatable/equatable.dart';

class ErrorType with EquatableMixin {
  final String value;

  ErrorType(this.value);

  @override
  List<Object> get props => [value];
}