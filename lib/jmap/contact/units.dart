import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'units.g.dart';

@JsonSerializable()
class Units with EquatableMixin {
  final String? type;
  final String? name;

  Units({this.type, this.name});

  factory Units.fromJson(Map<String, dynamic> json) => _$UnitsFromJson(json);

  Map<String, dynamic> toJson() => _$UnitsToJson(this);

  @override
  List<Object?> get props => [type, name];

  @override
  String toString() {
    return 'Units(type: $type, name: $name)';
  }
}