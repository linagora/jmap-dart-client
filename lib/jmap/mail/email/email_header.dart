import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email_header.g.dart';

@JsonSerializable()
class EmailHeader with EquatableMixin {
  final String name;
  final String value;

  EmailHeader(this.name, this.value);

  factory EmailHeader.fromJson(Map<String, dynamic> json) => _$EmailHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$EmailHeaderToJson(this);

  @override
  List<Object?> get props => [name, value];
}