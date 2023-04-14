import 'package:jmap_dart_client/http/converter/account_id_converter.dart';
import 'package:jmap_dart_client/http/converter/id_converter.dart';
import 'package:jmap_dart_client/http/converter/state_converter.dart';
import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:jmap_dart_client/jmap/core/method/response/get_response.dart';
import 'package:jmap_dart_client/jmap/core/state.dart';
import 'package:jmap_dart_client/jmap/mail/mailbox/mailbox.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_mailbox_response.g.dart';

@StateConverter()
@AccountIdConverter()
@IdConverter()
@JsonSerializable()
class GetMailboxResponse extends GetResponse<Mailbox>
 {
  GetMailboxResponse(AccountId accountId, State state, List<Mailbox> list, List<Id>? notFound) : super(accountId, state, list, notFound);

  factory GetMailboxResponse.fromJson(Map<String, dynamic> json) => _$GetMailboxResponseFromJson(json);

  static GetMailboxResponse deserialize(Map<String, dynamic> json) {
    return GetMailboxResponse.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetMailboxResponseToJson(this);

  @override
  List<Object?> get props => [accountId, state, list, notFound];
}