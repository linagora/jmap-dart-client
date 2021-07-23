import 'package:equatable/equatable.dart';
import 'package:jmap_dart_client/http/converter/method_call_id_converter.dart';
import 'package:jmap_dart_client/http/converter/method_name_converter.dart';
import 'package:jmap_dart_client/http/converter/reference_path_converter.dart';
import 'package:jmap_dart_client/jmap/core/request/reference_path.dart';
import 'package:jmap_dart_client/jmap/core/request/request_invocation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'result_reference.g.dart';

@ReferencePathConverter()
@MethodNameConverter()
@MethodCallIdConverter()
@JsonSerializable()
class ResultReference with EquatableMixin {
  final MethodCallId resultOf;
  final MethodName name;
  final ReferencePath path;

  ResultReference(this.resultOf, this.name, this.path);

  @override
  List<Object?> get props => [resultOf, name, path];

  factory ResultReference.fromJson(Map<String, dynamic> json) => _$ResultReferenceFromJson(json);

  Map<String, dynamic> toJson() => _$ResultReferenceToJson(this);
}