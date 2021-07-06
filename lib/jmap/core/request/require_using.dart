import 'dart:collection';

import '../capability/capability.dart';

mixin RequiredUsing {
  final Set<CapabilityIdentifier> capabilities = HashSet.identity();

  void using(CapabilityIdentifier capabilityIdentifier) {
    capabilities.add(capabilityIdentifier);
  }

  void usings(Set<CapabilityIdentifier> capabilityIdentifiers) {
    capabilities.addAll(capabilityIdentifiers);
  }
}