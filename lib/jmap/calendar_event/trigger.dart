import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/contact/related_to_values.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trigger.g.dart';

@JsonSerializable()
class Trigger with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type; // "OffsetTrigger" | "AbsoluteTrigger" | "UnknownTrigger"

  @JsonKey(includeIfNull: false)
  final String? relativeTo; 

  @JsonKey(includeIfNull: false)
  final String? offset; 

  @JsonKey(includeIfNull: false)
  final String? when; 

  @JsonKey(includeIfNull: false)
  final Map<String, RelatedToValue>? relatedTo;

  Trigger({
    this.type,
    this.relativeTo,
    this.offset,
    this.when,
    this.relatedTo,
  });

  factory Trigger.offset({
    required String offset,
    String relativeTo = 'start',
  }) =>
      Trigger(
        type: 'OffsetTrigger',
        offset: offset,
        relativeTo: relativeTo,
      );

  factory Trigger.absolute({
    required String when,
    Map<String, RelatedToValue>? relatedTo,
  }) =>
      Trigger(
        type: 'AbsoluteTrigger',
        when: when,
        relatedTo: relatedTo,
      );

  factory Trigger.fromJson(Map<String, dynamic> json) =>
      _$TriggerFromJson(json);

  Map<String, dynamic> toJson() => _$TriggerToJson(this);

  @override
  List<Object?> get props =>
      [type, relativeTo, offset, when, relatedTo];

  @override
  String toString() {
    return 'Trigger('
        'type: $type, '
        'relativeTo: $relativeTo, '
        'offset: $offset, '
        'when: $when, '
        'relatedTo: $relatedTo'
        ')';
  }
}
