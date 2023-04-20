import 'package:json_annotation/json_annotation.dart';

enum DayOfWeek {
  @JsonValue('mo')
  monday,
  @JsonValue('tu')
  tuesday,
  @JsonValue('we')
  wednesday,
  @JsonValue('th')
  thursday,
  @JsonValue('fr')
  friday,
  @JsonValue('sa')
  saturday,
  @JsonValue('su')
  sunday;
}