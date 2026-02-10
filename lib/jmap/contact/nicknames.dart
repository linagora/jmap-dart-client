import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nicknames.g.dart';

@JsonSerializable()
class Nickname with EquatableMixin {
  final String? name;

  Nickname({this.name = 'Nickname'});

  factory Nickname.fromJson(Map<String, dynamic> json) =>
      _$NicknameFromJson(json);

  Map<String, dynamic> toJson() => _$NicknameToJson(this);

  @override
  List<Object?> get props => [name];

  @override
  String toString() => 'Nickname(name: $name)';
}
