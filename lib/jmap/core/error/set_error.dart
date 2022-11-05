import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/error_type_converter.dart';
import 'package:jmap_dart_client/jmap/core/error/error_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'set_error.g.dart';

@ErrorTypeConverter()
@JsonSerializable(explicitToJson: true)
class SetError with EquatableMixin {
  static final forbidden = ErrorType("forbidden");
  static final overQuota = ErrorType("overQuota");
  static final tooLarge = ErrorType("tooLarge");
  static final notFound = ErrorType("notFound");
  static final invalidPatch = ErrorType("invalidPatch");
  static final willDestroy = ErrorType("willDestroy");
  static final invalidProperties = ErrorType("invalidProperties");
  static final singleton = ErrorType("singleton");

  final ErrorType type;
  final String? description;
  final Set<String>? properties;

  SetError(this.type, {this.description, this.properties});

  @override
  List<Object?> get props => [type, description, properties];

  factory SetError.fromJson(Map<String, dynamic> json) => _$SetErrorFromJson(json);

  Map<String, dynamic> toJson() => _$SetErrorToJson(this);

  Set<ErrorType> get errorTypesJMAPSupport => {
    SetError.forbidden,
    SetError.overQuota,
    SetError.tooLarge,
    SetError.notFound,
    SetError.invalidPatch,
    SetError.willDestroy,
    SetError.invalidProperties,
    SetError.singleton,
  };
}