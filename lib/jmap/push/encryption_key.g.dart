// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encryption_key.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EncryptionKey _$EncryptionKeyFromJson(Map<String, dynamic> json) =>
    EncryptionKey(
      json['p256dh'] as String,
      json['auth'] as String,
    );

Map<String, dynamic> _$EncryptionKeyToJson(EncryptionKey instance) =>
    <String, dynamic>{
      'p256dh': instance.publicKey,
      'auth': instance.authenticationSecret,
    };
