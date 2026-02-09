import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class LocationValue with EquatableMixin {

  @JsonKey(includeIfNull: false)
  final String? type;

  @JsonKey(includeIfNull: false)
  final String? name;

  LocationValue({this.type = 'Location', this.name});

  factory LocationValue.fromJson(Map<String, dynamic> json) => _$ParticipantValueFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantValueToJson(this);

  @override
  List<Object?> get props => [type, name];

  @override
  String toString() => 'LocationValue(type: $type, name: $name)';
}

LocationValue _$ParticipantValueFromJson(Map<String, dynamic> json) =>
    LocationValue(
      type: json['@type'] as String?,
      name: json['name'] as String?
    );

Map<String, dynamic> _$ParticipantValueToJson(LocationValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@type', instance.type);
  writeNotNull('name', instance.name);
  return val;
}
