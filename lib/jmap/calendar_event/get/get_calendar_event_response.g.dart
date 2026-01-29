// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_calendar_event_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCalendarEventResponse _$GetCalendarEventResponseFromJson(
        Map<String, dynamic> json) =>
    GetCalendarEventResponse(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      _$JsonConverterFromJson<String, State>(
          json['state'], const StateConverter().fromJson),
      (json['list'] as List<dynamic>?)
          ?.map((e) => CalendarEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['notFound'] as List<dynamic>?)
          ?.map((e) => const IdConverter().fromJson(e as String))
          .toList(),
    );

Map<String, dynamic> _$GetCalendarEventResponseToJson(
        GetCalendarEventResponse instance) =>
    <String, dynamic>{
      'accountId': const AccountIdConverter().toJson(instance.accountId),
      'state': const StateConverter().toJson(instance.state),
      'list': instance.list,
      'notFound': instance.notFound?.map(const IdConverter().toJson).toList(),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
