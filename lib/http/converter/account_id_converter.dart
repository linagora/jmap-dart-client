import 'package:jmap_dart_client/jmap/account_id.dart';
import 'package:jmap_dart_client/jmap/core/id.dart';
import 'package:json_annotation/json_annotation.dart';

class AccountIdConverter implements JsonConverter<AccountId, String> {
  const AccountIdConverter();

  @override
  AccountId fromJson(String json) => AccountId(Id(json));

  @override
  String toJson(AccountId object) => object.id.value;
}