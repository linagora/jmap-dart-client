import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/jmap/core/error/error_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'set_error.g.dart';

@JsonSerializable(explicitToJson: true)
class SetError with EquatableMixin {
  final ErrorType type;
  final String? description;
  final Set<String>? properties;

  SetError(this.type, {this.description, this.properties});

  @override
  List<Object?> get props => [type, description, properties];

  factory SetError.fromJson(Map<String, dynamic> json) => _$SetErrorFromJson(json);

  Map<String, dynamic> toJson() => _$SetErrorToJson(this);
}