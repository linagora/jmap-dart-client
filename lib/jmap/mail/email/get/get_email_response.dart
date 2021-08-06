import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/email_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/get_response.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/mail/email/email.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_email_response.g.dart';

@EmailConverter()
@StateConverter()
@AccountIdConverter()
@IdConverter()
@JsonSerializable()
class GetEmailResponse extends GetResponse<Email> {
  GetEmailResponse(AccountId accountId, State state, List<Email> list, List<Id>? notFound) : super(accountId, state, list, notFound);

  factory GetEmailResponse.fromJson(Map<String, dynamic> json) => _$GetEmailResponseFromJson(json);

  static GetEmailResponse deserialize(Map<String, dynamic> json) {
    return GetEmailResponse.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetEmailResponseToJson(this);

  @override
  List<Object?> get props => [accountId, state, list, notFound];
}