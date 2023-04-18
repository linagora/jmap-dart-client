import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/get_response.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/identities/identity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_identity_response.g.dart';

@StateConverter()
@AccountIdConverter()
@IdConverter()
@JsonSerializable()
class GetIdentityResponse extends GetResponse<Identity> {
  GetIdentityResponse(
      AccountId accountId, State state, List<Identity> list, List<Id>? notFound)
      : super(accountId, state, list, notFound);

  factory GetIdentityResponse.fromJson(Map<String, dynamic> json) =>
      _$GetIdentityResponseFromJson(json);

  static GetIdentityResponse deserialize(Map<String, dynamic> json) {
    return GetIdentityResponse.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetIdentityResponseToJson(this);

  @override
  List<Object?> get props => [accountId, state, list, notFound];
}
