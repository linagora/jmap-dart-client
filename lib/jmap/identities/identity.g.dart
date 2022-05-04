// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Identity _$IdentityFromJson(Map<String, dynamic> json) => Identity(
      id: const IdentityIdNullableConverter().fromJson(json['id'] as String?),
      description: json['description'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      bcc: (json['bcc'] as List<dynamic>?)
          ?.map((e) => EmailAddress.fromJson(e as Map<String, dynamic>))
          .toSet(),
      replyTo: (json['replyTo'] as List<dynamic>?)
          ?.map((e) => EmailAddress.fromJson(e as Map<String, dynamic>))
          .toSet(),
      textSignature: const SignatureNullableConverter()
          .fromJson(json['textSignature'] as String?),
      htmlSignature: const SignatureNullableConverter()
          .fromJson(json['htmlSignature'] as String?),
      mayDelete: json['mayDelete'] as bool?,
    );

Map<String, dynamic> _$IdentityToJson(Identity instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', const IdentityIdNullableConverter().toJson(instance.id));
  writeNotNull('description', instance.description);
  writeNotNull('name', instance.name);
  writeNotNull('email', instance.email);
  writeNotNull('bcc', instance.bcc?.toList());
  writeNotNull('replyTo', instance.replyTo?.toList());
  writeNotNull('textSignature',
      const SignatureNullableConverter().toJson(instance.textSignature));
  writeNotNull('htmlSignature',
      const SignatureNullableConverter().toJson(instance.htmlSignature));
  writeNotNull('mayDelete', instance.mayDelete);
  return val;
}
