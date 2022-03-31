
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'encryption_key.g.dart';

@JsonSerializable()
class EncryptionKey with EquatableMixin {

  @JsonKey(name: 'p256dh')
  final String publicKey;

  @JsonKey(name: 'auth')
  final String authenticationSecret;

  EncryptionKey(this.publicKey, this.authenticationSecret);

  factory EncryptionKey.fromJson(Map<String, dynamic> json) => _$EncryptionKeyFromJson(json);

  Map<String, dynamic> toJson() => _$EncryptionKeyToJson(this);

  @override
  List<Object?> get props => [publicKey, authenticationSecret];
}