import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/method/method.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class ChangesMethod extends MethodRequiringAccountId {
  final State sinceState;

  @JsonKey(includeIfNull: false)
  final UnsignedInt? maxChanges;

  ChangesMethod(AccountId accountId, this.sinceState, {this.maxChanges}) : super(accountId);
}