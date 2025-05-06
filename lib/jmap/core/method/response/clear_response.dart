import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/error/set_error.dart';
import 'package:jmap_dart_client/jmap/core/method/method_response.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';

abstract class ClearResponse extends ResponseRequiringAccountId {
  final UnsignedInt? totalDeletedMessagesCount;
  final SetError? notCleared;

  ClearResponse(
    AccountId accountId,
    this.totalDeletedMessagesCount,
    this.notCleared,
  ) : super(accountId);
}