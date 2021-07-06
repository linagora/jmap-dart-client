import 'package:jmap_dart_client/jmap/core/method/method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';

mixin RequireMethodCall<T extends Method> {
  final List<RequestInvocation> invocations = List.empty(growable: true);

  void methodCalls(List<RequestInvocation> newInvocations) {
    invocations.addAll(newInvocations);
  }
}