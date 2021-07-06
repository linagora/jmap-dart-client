import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';


class ResponseInvocation {
  final MethodName methodName;
  final ResponseArguments arguments;
  final MethodCallId methodCallId;

  ResponseInvocation(this.methodName, this.arguments, this.methodCallId);
}

class ResponseArguments {
  final dynamic value;

  ResponseArguments(this.value);
}