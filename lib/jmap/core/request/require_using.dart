
import 'package:built_collection/built_collection.dart';

import '../capability/capability.dart';

mixin RequiredUsing {
  final SetBuilder<CapabilityIdentifier> capabilitiesBuilder = SetBuilder();

  void using(CapabilityIdentifier capabilityIdentifier) {
    capabilitiesBuilder.add(capabilityIdentifier);
  }

  void usings(Set<CapabilityIdentifier> capabilityIdentifiers) {
    capabilitiesBuilder.addAll(capabilityIdentifiers);
  }
}