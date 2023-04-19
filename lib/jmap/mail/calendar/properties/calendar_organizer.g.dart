// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_organizer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarOrganizer _$CalendarOrganizerFromJson(Map<String, dynamic> json) =>
    CalendarOrganizer(
      name: json['name'] as String?,
      mailto: const MailAddressNullableConverter()
          .fromJson(json['mailto'] as String?),
    );

Map<String, dynamic> _$CalendarOrganizerToJson(CalendarOrganizer instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull(
      'mailto', const MailAddressNullableConverter().toJson(instance.mailto));
  return val;
}
