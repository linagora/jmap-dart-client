// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VacationResponse _$VacationResponseFromJson(Map<String, dynamic> json) =>
    VacationResponse(
      id: const VacationIdNullableConverter().fromJson(json['id'] as String?),
      isEnabled: json['isEnabled'] as bool?,
      fromDate: const UTCDateNullableConverter()
          .fromJson(json['fromDate'] as String?),
      toDate:
          const UTCDateNullableConverter().fromJson(json['toDate'] as String?),
      subject: json['subject'] as String?,
      textBody: json['textBody'] as String?,
      htmlBody: json['htmlBody'] as String?,
    );

Map<String, dynamic> _$VacationResponseToJson(VacationResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', const VacationIdNullableConverter().toJson(instance.id));
  writeNotNull('isEnabled', instance.isEnabled);
  val['fromDate'] = const UTCDateNullableConverter().toJson(instance.fromDate);
  val['toDate'] = const UTCDateNullableConverter().toJson(instance.toDate);
  val['subject'] = instance.subject;
  val['textBody'] = instance.textBody;
  val['htmlBody'] = instance.htmlBody;
  return val;
}
