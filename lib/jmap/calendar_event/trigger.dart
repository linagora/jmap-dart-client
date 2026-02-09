import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class Trigger with EquatableMixin {

  @JsonKey(includeIfNull: false)
  final String? type;

  @JsonKey(includeIfNull: false)
  final String? relativeTo;

  @JsonKey(includeIfNull: false)
  final String? offset;

  Trigger({this.type = 'OffsetTrigger', this.relativeTo, this.offset});

  factory Trigger.fromJson(Map<String, dynamic> json) => _$TriggerFromJson(json);

  Map<String, dynamic> toJson() => _$TriggerToJson(this);

  @override
  List<Object?> get props => [type, relativeTo, offset];

  @override
  String toString() {
    return 'Trigger('
        'type: $type, '
        'relativeTo: $relativeTo, '
        'offset: $offset'
        ')';
  }
}

Trigger _$TriggerFromJson(Map<String, dynamic> json) => Trigger(
  type: json['@type'] as String?,
  relativeTo: json['relativeTo'] as String?,
  offset: json['offset'] as String?,
);

Map<String, dynamic> _$TriggerToJson(Trigger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  writeNotNull('relativeTo', instance.relativeTo);
  writeNotNull('offset', instance.offset);
  return val;
}
