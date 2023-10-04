import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/method.dart';
import 'package:jmap_dart_client/jmap/core/method/request/get_method.dart';

abstract class ParseMethod<T> extends MethodRequiringAccountId with OptionalProperties {

  final Set<Id> blobIds;

  ParseMethod(AccountId accountId, this.blobIds) : super(accountId);
}