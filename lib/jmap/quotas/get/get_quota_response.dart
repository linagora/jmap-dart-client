import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/get_response.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/quotas/quota.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_quota_response.g.dart';

@StateConverter()
@AccountIdConverter()
@IdConverter()
@JsonSerializable()
class GetQuotaResponse extends GetResponse<Quota> {
  GetQuotaResponse(
    AccountId accountId,
    State state,
    List<Quota> list,
    List<Id>? notFound
  ) : super(accountId, state, list, notFound);

  factory GetQuotaResponse.fromJson(Map<String, dynamic> json) => _$GetQuotaResponseFromJson(json);

  static GetQuotaResponse deserialize(Map<String, dynamic> json) {
    return GetQuotaResponse.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetQuotaResponseToJson(this);

  @override
  List<Object?> get props => [accountId, state, list, notFound];
}