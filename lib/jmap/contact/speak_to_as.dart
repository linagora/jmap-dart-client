import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/contact/pronouns.dart';
import 'package:json_annotation/json_annotation.dart';

part 'speak_to_as.g.dart';

@JsonSerializable(explicitToJson: true)
class SpeakToAs with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type;
  @JsonKey(includeIfNull: false)
  final String? grammaticalGender;
  @JsonKey(includeIfNull: false)
  final Map<String, Pronouns>? pronouns;

  SpeakToAs({
    this.type,
    this.grammaticalGender,
    this.pronouns,
  });

  factory SpeakToAs.speakToAs({
    String? grammaticalGender,
    Map<String, Pronouns>? pronouns,
  }) =>
      SpeakToAs(
        type: 'SpeakToAs',
        grammaticalGender: grammaticalGender,
        pronouns: pronouns,
      );

  factory SpeakToAs.fromJson(Map<String, dynamic> json) =>
      _$SpeakToAsFromJson(json);

  Map<String, dynamic> toJson() => _$SpeakToAsToJson(this);

  @override
  List<Object?> get props => [type, grammaticalGender, pronouns];

  @override
  String toString() {
    return 'SpeakToAs('
        'type: $type, '
        'grammaticalGender: $grammaticalGender, '
        'pronouns: $pronouns'
        ')';
  }
}

