// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keywords.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Keyword _$KeywordFromJson(Map<String, dynamic> json) => Keyword(
      anniversary: json['anniversary'] as bool?,
      appointment: json['appointment'] as bool?,
      business: json['business'] as bool?,
      education: json['education'] as bool?,
      holiday: json['holiday'] as bool?,
      meeting: json['meeting'] as bool?,
      miscellaneous: json['miscellaneous'] as bool?,
      nonWorkingHrs: json['nonWorkingHrs'] as bool?,
      notInOffice: json['notInOffice'] as bool?,
      personal: json['personal'] as bool?,
      phoneCall: json['phoneCall'] as bool?,
      sickDay: json['sickDay'] as bool?,
      specialOccasion: json['specialOccasion'] as bool?,
      travel: json['travel'] as bool?,
      vacation: json['vacation'] as bool?,
    );

Map<String, dynamic> _$KeywordToJson(Keyword instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('anniversary', instance.anniversary);
  writeNotNull('appointment', instance.appointment);
  writeNotNull('business', instance.business);
  writeNotNull('education', instance.education);
  writeNotNull('holiday', instance.holiday);
  writeNotNull('meeting', instance.meeting);
  writeNotNull('miscellaneous', instance.miscellaneous);
  writeNotNull('nonWorkingHrs', instance.nonWorkingHrs);
  writeNotNull('notInOffice', instance.notInOffice);
  writeNotNull('personal', instance.personal);
  writeNotNull('phoneCall', instance.phoneCall);
  writeNotNull('sickDay', instance.sickDay);
  writeNotNull('specialOccasion', instance.specialOccasion);
  writeNotNull('travel', instance.travel);
  writeNotNull('vacation', instance.vacation);
  return val;
}
