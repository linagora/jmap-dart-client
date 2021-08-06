import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collation_identifier.g.dart';

@JsonSerializable()
class CollationIdentifier with EquatableMixin {
  final String value;

  CollationIdentifier(this.value);

  @override
  List<Object> get props => [value];

  factory CollationIdentifier.fromJson(Map<String, dynamic> json) => _$CollationIdentifierFromJson(json);

  Map<String, dynamic> toJson() => _$CollationIdentifierToJson(this);
}