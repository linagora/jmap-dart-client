import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'street.g.dart';

@JsonSerializable()
class Street with EquatableMixin {
  final String? value;

  Street({this.value});

  factory Street.fromJson(Map<String, dynamic> json) => _$StreetFromJson(json);

  Map<String, dynamic> toJson() => _$StreetToJson(this);

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'Street(value: $value)';
}