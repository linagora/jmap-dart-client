import 'package:equatable/equatable.dart';
<<<<<<< HEAD
import 'package:jmap_dart_client/http/converter/calendar_event/patch_object_map_converter.dart';
=======
>>>>>>> c2b9970 (deleted unused files, made names of the files consistent (singuar) added some helper method that were craeting some issue in server test)
import 'package:json_annotation/json_annotation.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';

part 'recurrence_overrides.g.dart';

@JsonSerializable()
class RecurrenceOverrides extends Equatable {
  final Map<String, PatchObject> overrides;

  const RecurrenceOverrides(this.overrides);

  factory RecurrenceOverrides.fromJson(Map<String, dynamic> json) =>
      RecurrenceOverrides(
        json.map(
          (key, value) => MapEntry(
            key,
            PatchObject(Map<String, dynamic>.from(value as Map)),
          ),
        ),
      );

  Map<String, dynamic> toJson() =>
      overrides.map((key, patch) => MapEntry(key, patch.toJson()));

  @override
  List<Object?> get props => [overrides];
}
