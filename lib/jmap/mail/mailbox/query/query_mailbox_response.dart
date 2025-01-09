import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/http/converter/unsigned_int_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/query_response.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/core/unsigned_int.dart';
import 'package:json_annotation/json_annotation.dart';

part 'query_mailbox_response.g.dart';

@UnsignedIntConverter()
@IdConverter()
@StateConverter()
@AccountIdConverter()
@JsonSerializable()
class QueryMailboxResponse extends QueryResponse {

  QueryMailboxResponse(
    AccountId accountId,
    State queryState,
    bool canCalculateChanges,
    UnsignedInt position,
    Set<Id> ids,
    UnsignedInt? total,
    UnsignedInt? limit,
  ) : super(accountId, queryState, canCalculateChanges, position, ids, total, limit);

  factory QueryMailboxResponse.fromJson(Map<String, dynamic> json) => _$QueryMailboxResponseFromJson(json);

  static QueryMailboxResponse deserialize(Map<String, dynamic> json) {
    return QueryMailboxResponse.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$QueryMailboxResponseToJson(this);

  @override
  List<Object?> get props => [accountId, queryState, canCalculateChanges, position, total, ids];
}