import 'package:jmap_dart_client/jmap/core/request/require_method_call.dart';

import '../capability.dart';

mixin RequiredUsing implements RequireMethodCall {
  final Set<CapabilityIdentifier> capabilities = Set();

  RequiredUsing using(CapabilityIdentifier capabilityIdentifier) {
    capabilities.add(capabilityIdentifier);
    return this;
  }
}