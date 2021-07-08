import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/core/request/reference_path.dart';
import 'package:jmap_dart_client/jmap/core/request/result_reference.dart';

import '../method/method.dart';

class RequestInvocation {
  final MethodName methodName;
  final Arguments arguments;
  final MethodCallId methodCallId;

  RequestInvocation(this.methodName, this.arguments, this.methodCallId);

  ResultReference createResultReference(ReferencePath path) {
    return ResultReference(methodCallId, arguments.value.methodName, path);
  }
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