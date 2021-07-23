import 'package:jmap_dart_client/jmap/core/account/account.dart';
import 'package:json_annotation/json_annotation.dart';

class AccountNameConverter implements JsonConverter<AccountName, String> {
  const AccountNameConverter();

  @override
  AccountName fromJson(String json) => AccountName(json);

  @override
  String toJson(AccountName object) => object.value;
}