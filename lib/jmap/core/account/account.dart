import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_identifier.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability_properties.dart';

class Account with EquatableMixin {

  final AccountName name;
  final bool isPersonal;
  final bool isReadOnly;
  final Map<CapabilityIdentifier, CapabilityProperties> accountCapabilities;

  Account(
    this.name,
    this.isPersonal,
    this.isReadOnly,
    this.accountCapabilities,
  );

  @override
  List<Object> get props => [name];
}

class AccountName with EquatableMixin {

  final String value;

  AccountName(this.value);

  @override
  List<Object> get props => [value];
}
