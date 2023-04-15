// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Parsed _$ParsedFromJson(Map<String, dynamic> json) => Parsed(
      calendarEvent: json['calendarEvent'] == null
          ? null
          : CalendarEvent.fromJson(
              json['calendarEvent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ParsedToJson(Parsed instance) => <String, dynamic>{
      'calendarEvent': instance.calendarEvent,
    };
