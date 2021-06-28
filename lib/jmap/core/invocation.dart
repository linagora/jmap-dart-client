import 'package:equatable/equatable.dart';

class Invocation<T extends Object> {
  final MethodName methodName;
  final Arguments<T> arguments;
  final MethodCallId methodCallId;

  Invocation(this.methodName, this.arguments, this.methodCallId);
}

class MethodName with EquatableMixin {
  final String value;

  MethodName(this.value);

  @override
  List<Object> get props => [value];
}

class Arguments<T extends Object> with EquatableMixin {
  final T value;

  Arguments(this.value);

  @override
  List<Object> get props => [value];
}

class MethodCallId with EquatableMixin {
  final String value;

  MethodCallId(this.value);

  @override
  List<Object> get props => [value];
}