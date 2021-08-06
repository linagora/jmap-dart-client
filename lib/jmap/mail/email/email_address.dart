import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email_address.g.dart';

@JsonSerializable()
class EmailAddress with EquatableMixin {
  final String? name;
  final String? email;

  EmailAddress(this.name, this.email);

  factory EmailAddress.fromJson(Map<String, dynamic> json) => _$EmailAddressFromJson(json);

  Map<String, dynamic> toJson() => _$EmailAddressToJson(this);

  @override
  List<Object?> get props => [name, email];
}