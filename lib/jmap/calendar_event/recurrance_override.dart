import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/core/patch_object.dart';

class RecurrenceOverrides extends Equatable {
  final Map<String, PatchObject> overrides;

  const RecurrenceOverrides(this.overrides);

  factory RecurrenceOverrides.fromJson(Map<String, dynamic> json) {
    return RecurrenceOverrides(
      json.map(
        (key, value) => MapEntry(
          key,
          PatchObject(value as Map<String, dynamic>),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return overrides.map(
      (key, patch) => MapEntry(
        key,
        patch, 
      ),
    );
  }

  @override
  List<Object?> get props => [overrides];
}
