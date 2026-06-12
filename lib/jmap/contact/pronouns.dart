import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/util/util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pronouns.g.dart';

@JsonSerializable()
class Pronouns with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type;

  final String pronouns;

  @JsonKey(includeIfNull: false, fromJson: parseIntNullable)
  final int? pref;

  Pronouns({
    this.type = 'Pronouns',
    required this.pronouns,
    this.pref,
  });

  factory Pronouns.fromJson(Map<String, dynamic> json) =>
      _$PronounsFromJson(json);

  Map<String, dynamic> toJson() => _$PronounsToJson(this);

  @override
  List<Object?> get props => [type, pronouns, pref];

  @override
  String toString() => 'Pronouns(type: $type, pronouns: $pronouns, pref: $pref)';
}
