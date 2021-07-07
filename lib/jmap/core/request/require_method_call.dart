import 'package:built_collection/built_collection.dart';
import 'package:jmap_dart_client/jmap/core/method/method.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';

mixin RequireMethodCall<T extends Method> {
  final ListBuilder<RequestInvocation> invocationsBuilder = ListBuilder();

  void methodCalls(List<RequestInvocation> newInvocations) {
    invocationsBuilder.addAll(newInvocations);
  }
}