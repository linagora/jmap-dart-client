import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/method/method.dart';

abstract class ClearMethod extends MethodRequiringAccountId {
  ClearMethod(AccountId accountId) : super(accountId);
}