import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_type.g.dart';

@JsonSerializable()
class ErrorType with EquatableMixin {
  final String value;

  ErrorType(this.value);

  @override
  List<Object> get props => [value];

  factory ErrorType.fromJson(Map<String, dynamic> json) => _$ErrorTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorTypeToJson(this);
}