import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email_body_value.g.dart';

@JsonSerializable()
class EmailBodyValue with EquatableMixin {
  final String value;
  final bool isEncodingProblem;
  final bool isTruncated;

  EmailBodyValue(this.value, this.isEncodingProblem, this.isTruncated);

  factory EmailBodyValue.fromJson(Map<String, dynamic> json) => _$EmailBodyValueFromJson(json);

  Map<String, dynamic> toJson() => _$EmailBodyValueToJson(this);

  @override
  List<Object?> get props => [value, isEncodingProblem, isTruncated];
}