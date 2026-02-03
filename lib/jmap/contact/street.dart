import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'street.g.dart';

@JsonSerializable()
class Street with EquatableMixin {
  final String? typeName;
  final String? type;
  final String? value;

  Street({this.typeName, this.type, this.value});

  factory Street.fromJson(Map<String, dynamic> json) => _$StreetFromJson(json);

  Map<String, dynamic> toJson() => _$StreetToJson(this);

  @override
  List<Object?> get props => [typeName, type, value];

  @override
  String toString() {
    return 'Street(typeName: $typeName, type: $type, value: $value)';
  }
}