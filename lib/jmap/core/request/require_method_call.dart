import 'package:jmap_dart_client/jmap/core/invocation.dart' as jmapInvocation;
import 'package:jmap_dart_client/jmap/core/request/ready_to_build.dart';

mixin RequireMethodCall {
  final List<jmapInvocation.Invocation> invocations = List.empty(growable: true);

  RequireMethodCall methodCall(jmapInvocation.Invocation invocation) {
    invocations.add(invocation);
    return this;
  }

  ReadyToBuild ready();
}