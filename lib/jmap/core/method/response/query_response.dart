import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/method_response.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';

abstract class QueryResponse extends ResponseRequiringAccountId {
  final State queryState;
  final bool canCalculateChanges;
  final UnsignedInt position;
  final Set<Id> ids;
  final UnsignedInt total;
  final UnsignedInt limit;

  QueryResponse(
    AccountId accountId,
    this.queryState,
    this.canCalculateChanges,
    this.position,
    this.ids,
    this.total,
    this.limit,
  ) : super(accountId);
}