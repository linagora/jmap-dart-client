import 'package:equatable/equatable.dart';

import '../method/method.dart';

class RequestInvocation {
  final MethodName methodName;
  final Arguments arguments;
  final MethodCallId methodCallId;

  RequestInvocation(this.methodName, this.arguments, this.methodCallId);
}

class MethodName with EquatableMixin {
  final String value;

  MethodName(this.value);

  @override
  List<Object> get props => [value];
}

class Arguments<T extends Method> {
  final T value;

  Arguments(this.value);
}

class MethodCallId with EquatableMixin {
  final String value;

  MethodCallId(this.value);

  @override
  List<Object> get props => [value];
}