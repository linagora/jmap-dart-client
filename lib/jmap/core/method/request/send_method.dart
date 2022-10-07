import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/method.dart';
import 'package:jmap_dart_client/jmap/mdn/mdn.dart';

abstract class SendMethod<T> extends MethodRequiringAccountId {

  final Map<Id, MDN> send;

  SendMethod(AccountId accountId, this.send) : super(accountId);
}