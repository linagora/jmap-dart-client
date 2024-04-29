// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_reject_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarEventRejectMethod _$CalendarEventRejectMethodFromJson(
        Map<String, dynamic> json) =>
    CalendarEventRejectMethod(
      const AccountIdConverter().fromJson(json['accountId'] as String),
      blobIds: (json['blobIds'] as List<dynamic>)
          .map((e) => const IdConverter().fromJson(e as String))
          .toList(),
    )..language = json['language'] as String?;

Map<String, dynamic> _$CalendarEventRejectMethodToJson(
    CalendarEventRejectMethod instance) {
  final val = <String, dynamic>{
    'accountId': const AccountIdConverter().toJson(instance.accountId),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('language', instance.language);
  val['blobIds'] = instance.blobIds.map(const IdConverter().toJson).toList();
  return val;
}
