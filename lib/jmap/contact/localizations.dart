import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'localizations.g.dart';

@JsonSerializable()
class Localization with EquatableMixin {
  final Map<String, dynamic> patches;

  Localization({required this.patches});

  factory Localization.fromJson(Map<String, dynamic> json) =>
      _$LocalizationFromJson(json);

  Map<String, dynamic> toJson() => _$LocalizationToJson(this);

  @override
  List<Object?> get props => [patches];

  @override
  String toString() => 'Localization(patches: $patches)';
}
