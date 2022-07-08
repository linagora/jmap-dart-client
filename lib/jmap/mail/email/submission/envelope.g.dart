// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'envelope.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Envelope _$EnvelopeFromJson(Map<String, dynamic> json) => Envelope(
      Address.fromJson(json['mailFrom'] as Map<String, dynamic>),
      (json['rcptTo'] as List<dynamic>)
          .map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toSet(),
    );

Map<String, dynamic> _$EnvelopeToJson(Envelope instance) => <String, dynamic>{
      'mailFrom': instance.mailFrom.toJson(),
      'rcptTo': instance.rcptTo.map((e) => e.toJson()).toList(),
    };
