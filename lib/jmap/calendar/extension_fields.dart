import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'extension_fields.g.dart';

@JsonSerializable()
class ExtensionFields with EquatableMixin {
  final List<String>? xOPENPAASVIDEOCONFERENCE;
  final List<String>? xOPENPAASCUSTOMHEADER1;

  ExtensionFields({this.xOPENPAASVIDEOCONFERENCE, this.xOPENPAASCUSTOMHEADER1});

  factory ExtensionFields.fromJson(Map<String, dynamic> json) =>
      _$ExtensionFieldsFromJson(json);

  Map<String, dynamic> toJson() => _$ExtensionFieldsToJson(this);

  @override
  List<Object?> get props => [xOPENPAASVIDEOCONFERENCE, xOPENPAASCUSTOMHEADER1];
}
