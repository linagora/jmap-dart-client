import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/capability/capability.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';

abstract class Method with EquatableMixin {
  MethodName get methodName;

  Set<CapabilityIdentifier> get requiredCapabilities;

  Map<String, dynamic> toJson();
}

abstract class MethodRequiringAccountId extends Method {
  final AccountId accountId;

  MethodRequiringAccountId(this.accountId);
}
