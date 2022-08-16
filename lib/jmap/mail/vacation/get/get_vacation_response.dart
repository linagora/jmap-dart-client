import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/get_response.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/mail/vacation/vacation_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_vacation_response.g.dart';

@StateConverter()
@AccountIdConverter()
@IdConverter()
@JsonSerializable()
class GetVacationResponse extends GetResponse<VacationResponse> {
  GetVacationResponse(
    AccountId accountId,
    State state,
    List<VacationResponse> list,
    List<Id>? notFound
  ) : super(accountId, state, list, notFound);

  factory GetVacationResponse.fromJson(Map<String, dynamic> json) =>
      _$GetVacationResponseFromJson(json);

  static GetVacationResponse deserialize(Map<String, dynamic> json) {
    return GetVacationResponse.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetVacationResponseToJson(this);

  @override
  List<Object?> get props => [accountId, state, list, notFound];
}