import 'package:jmap_dart_client/jmap/core/user_name.dart';
import 'package:json_annotation/json_annotation.dart';

class UserNameConverter implements JsonConverter<UserName, String> {
  const UserNameConverter();

  @override
  UserName fromJson(String json) => UserName(json);

  @override
  String toJson(UserName object) => object.value;
}