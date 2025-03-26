// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEventAttendance _$CalendarEventAttendanceFromJson(
        Map<String, dynamic> json) =>
    CalendarEventAttendance(
      blobId: const IdNullableConverter().fromJson(json['blobId'] as String?),
      eventAttendanceStatus: $enumDecodeNullable(
          _$AttendanceStatusEnumMap, json['eventAttendanceStatus']),
      isFree: json['isFree'] as bool? ?? true,
    );

Map<String, dynamic> _$CalendarEventAttendanceToJson(
    CalendarEventAttendance instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('blobId', const IdNullableConverter().toJson(instance.blobId));
  writeNotNull('eventAttendanceStatus',
      _$AttendanceStatusEnumMap[instance.eventAttendanceStatus]);
  val['isFree'] = instance.isFree;
  return val;
}

const _$AttendanceStatusEnumMap = {
  AttendanceStatus.accepted: 'accepted',
  AttendanceStatus.rejected: 'rejected',
  AttendanceStatus.tentativelyAccepted: 'tentativelyAccepted',
  AttendanceStatus.needsAction: 'needsAction',
};
