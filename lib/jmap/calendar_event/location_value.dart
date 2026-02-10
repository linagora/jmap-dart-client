import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_value.g.dart';

@JsonSerializable()
class LocationValue with EquatableMixin {
  @JsonKey(includeIfNull: false, name: '@type')
  final String? type;

  @JsonKey(includeIfNull: false)
  final String? name;

  LocationValue({this.type = 'Location', this.name});

  factory LocationValue.fromJson(Map<String, dynamic> json) =>
      _$LocationValueFromJson(json);

  Map<String, dynamic> toJson() => _$LocationValueToJson(this);

  @override
  List<Object?> get props => [type, name];

  @override
  String toString() => 'LocationValue(type: $type, name: $name)';
}
