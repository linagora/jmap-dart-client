import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/capability_identifier_converter.dart';
import 'package:jmap_dart_client/http/converter/request_invocation_converter.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:jmap_dart_client/jmap/core/request/require_method_call.dart';
import 'package:jmap_dart_client/jmap/core/request/require_using.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_object.g.dart';

@CapabilityIdentifierConverter()
@RequestInvocationConverter()
@JsonSerializable()
class RequestObject with EquatableMixin {
  final Set<CapabilityIdentifier> using;
  final List<RequestInvocation> methodCalls;

  RequestObject(this.using, this.methodCalls);

  @override
  List<Object> get props => [using, methodCalls];

  Map<String, dynamic> toJson() => _$RequestObjectToJson(this);

  static RequestObjectBuilder builder()  {
    return RequestObjectBuilder();
  }
}

class RequestObjectBuilder with RequiredUsing, RequireMethodCall {

  RequestObject build() {
    return RequestObject(
      capabilitiesBuilder.build().asSet(),
      invocationsBuilder.build().asList());
  }
}
