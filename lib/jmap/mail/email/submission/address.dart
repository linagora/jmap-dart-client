import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address with EquatableMixin {
  final String email;
  @JsonKey(includeIfNull: false)
  final Object? parameters;

  Address(this.email, {this.parameters});

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  List<Object?> get props => [email, parameters];
}