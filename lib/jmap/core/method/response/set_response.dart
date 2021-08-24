import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/error/set_error.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/method_response.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';

abstract class SetResponse<T> extends ResponseRequiringAccountId {
  final State? oldState;
  final State newState;
  final Map<Id, T>? created;
  final Map<Id, T?>? updated;
  final Set<Id>? destroyed;
  final Map<Id, SetError>? notCreated;
  final Map<Id, SetError>? notUpdated;
  final Map<Id, SetError>? notDestroyed;

  SetResponse(AccountId accountId, this.newState, {
    this.oldState,
    this.created,
    this.updated,
    this.destroyed,
    this.notCreated,
    this.notUpdated,
    this.notDestroyed
  }) : super(accountId);
}