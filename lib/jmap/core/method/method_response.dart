import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';

abstract class MethodResponse with EquatableMixin {
}

abstract class ResponseRequiringAccountId extends MethodResponse {
  final AccountId accountId;

  ResponseRequiringAccountId(this.accountId);
}