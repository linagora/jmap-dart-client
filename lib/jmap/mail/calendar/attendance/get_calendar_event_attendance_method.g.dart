// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_calendar_event_attendance_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCalendarEventAttendanceMethod _$GetCalendarEventAttendanceMethodFromJson(
        Map<String, dynamic> json) =>
    GetCalendarEventAttendanceMethod(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      (json['blobIds'] as List<dynamic>)
          .map((e) => const IdConverter().fromJson(e as String))
          .toList(),
    )
      ..ids = (json['ids'] as List<dynamic>?)
          ?.map((e) => const IdConverter().fromJson(e as String))
          .toSet()
      ..referenceIds = json['#ids'] == null
          ? null
          : ResultReference.fromJson(json['#ids'] as Map<String, dynamic>)
      ..properties = const PropertiesConverter()
          .fromJson(json['properties'] as List<String>?)
      ..referenceProperties = json['#properties'] == null
          ? null
          : ResultReference.fromJson(
              json['#properties'] as Map<String, dynamic>);

Map<String, dynamic> _$GetCalendarEventAttendanceMethodToJson(
    GetCalendarEventAttendanceMethod instance) {
  final val = <String, dynamic>{
    'accountId': const AccountIdConverter().toJson(instance.accountId),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ids', instance.ids?.map(const IdConverter().toJson).toList());
  writeNotNull('#ids', instance.referenceIds?.toJson());
  writeNotNull(
      'properties', const PropertiesConverter().toJson(instance.properties));
  writeNotNull('#properties', instance.referenceProperties?.toJson());
  val['blobIds'] = instance.blobIds.map(const IdConverter().toJson).toList();
  return val;
}
