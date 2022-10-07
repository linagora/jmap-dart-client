import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/error/set_error.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/method_response.dart';

abstract class SendResponse<T> extends ResponseRequiringAccountId {
  final Map<Id, T>? sent;
  final Map<Id, SetError>? notSent;

  SendResponse(AccountId accountId, {
    this.sent,
    this.notSent
  }) : super(accountId);
}