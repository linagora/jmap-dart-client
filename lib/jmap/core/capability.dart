import 'package:equatable/equatable.dart';

class CapabilityIdentifier with EquatableMixin {
  static final jmapCore = CapabilityIdentifier('urn:ietf:params:jmap:core');
  static final jmapMail = CapabilityIdentifier('urn:ietf:params:jmap:mail');

  final String value;

  CapabilityIdentifier(this.value);

  @override
  List<Object> get props => [value];
}

