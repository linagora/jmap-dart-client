import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patch_object.g.dart';

@JsonSerializable()
class PatchObject with EquatableMixin {
  PatchObject(this.patches);

  final Map<String, dynamic> patches;

  factory PatchObject.fromJson(Map<String, dynamic> json) => _$PatchObjectFromJson(json);

  Map<String, dynamic> toJson() => _$PatchObjectToJson(this);

  @override
  List<Object?> get props => [patches];
}