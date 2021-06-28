import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/core/capability.dart';
import 'package:jmap_dart_client/jmap/core/invocation.dart' as jmapInvocation;
import 'package:jmap_dart_client/jmap/core/request/ready_to_build.dart';
import 'package:jmap_dart_client/jmap/core/request/require_method_call.dart';
import 'package:jmap_dart_client/jmap/core/request/require_using.dart';

class RequestObject with EquatableMixin {
  final Set<CapabilityIdentifier> using;
  final List<jmapInvocation.Invocation> methodCalls;

  RequestObject(this.using, this.methodCalls);

  @override
  List<Object> get props => [using, methodCalls];

  static RequiredUsing builder()  {
    return RequestObjectBuilder();
  }
}

class RequestObjectBuilder with RequiredUsing, RequireMethodCall, ReadyToBuild {

  @override
  ReadyToBuild ready() {
    return this;
  }

  @override
  RequestObject build() {
    return RequestObject(capabilities, invocations);
  }
}
