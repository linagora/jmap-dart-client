import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/calendar_event/path_object_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';

part 'recurrence_overrides.g.dart';

@JsonSerializable()
class RecurrenceOverrides extends Equatable {
  @PatchObjectMapConverter()
  final Map<String, PatchObject> overrides;

  const RecurrenceOverrides(this.overrides);

  factory RecurrenceOverrides.fromJson(Map<String, dynamic> json) =>
      _$RecurrenceOverridesFromJson(json);

  Map<String, dynamic> toJson() => _$RecurrenceOverridesToJson(this);

  @override
  List<Object?> get props => [overrides];
}
