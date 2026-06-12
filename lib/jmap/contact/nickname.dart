import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nickname.g.dart';

@JsonSerializable()
class Nickname with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type;

  final String? name;

  Nickname({this.type = 'NickName', this.name});

  factory Nickname.fromJson(Map<String, dynamic> json) =>
      _$NicknameFromJson(json);

  Map<String, dynamic> toJson() => _$NicknameToJson(this);

  @override
  List<Object?> get props => [type, name];

  @override
  String toString() => 'Nickname(type: $type, name: $name)';
}
