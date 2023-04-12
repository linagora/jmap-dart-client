import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'extension_fields.g.dart';

@JsonSerializable()
class ExtensionFields with EquatableMixin {
  final Map<String, List<String>>? videoconference;
  final Map<String, List<String>>? customheader;

  ExtensionFields({this.videoconference, this.customheader});

  factory ExtensionFields.fromJson(Map<String, dynamic> json) =>
      _$ExtensionFieldsFromJson(json);

  Map<String, dynamic> toJson() => _$ExtensionFieldsToJson(this);

  @override
  List<Object?> get props => [videoconference, customheader];
}
