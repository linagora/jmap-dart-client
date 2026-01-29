import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class Keyword with EquatableMixin {
  @JsonKey(includeIfNull: false)
  final bool? anniversary;

  @JsonKey(includeIfNull: false)
  final bool? appointment;

  @JsonKey(includeIfNull: false)
  final bool? business;

  @JsonKey(includeIfNull: false)
  final bool? education;

  @JsonKey(includeIfNull: false)
  final bool? holiday;

  @JsonKey(includeIfNull: false)
  final bool? meeting;

  @JsonKey(includeIfNull: false)
  final bool? miscellaneous;

  @JsonKey(includeIfNull: false)
  final bool? nonWorkingHrs;

  @JsonKey(includeIfNull: false)
  final bool? notInOffice;

  @JsonKey(includeIfNull: false)
  final bool? personal;

  @JsonKey(includeIfNull: false)
  final bool? phoneCall;

  @JsonKey(includeIfNull: false)
  final bool? sickDay;

  @JsonKey(includeIfNull: false)
  final bool? specialOccasion;

  @JsonKey(includeIfNull: false)
  final bool? travel;

  @JsonKey(includeIfNull: false)
  final bool? vacation;

  Keyword({this.anniversary, this.appointment, this.business, this.education, this.holiday, this.meeting, this.miscellaneous, this.nonWorkingHrs, this.notInOffice, this.personal, this.phoneCall, this.sickDay, this.specialOccasion, this.travel, this.vacation});

  factory Keyword.fromJson(Map<String, dynamic> json) => _$KeywordFromJson(json);

  Map<String, dynamic> toJson() => _$KeywordToJson(this);

  @override
  List<Object?> get props => [
        anniversary,
        appointment,
        business,
        education,
        holiday,
        meeting,
        miscellaneous,
        nonWorkingHrs,
        notInOffice,
        personal,
        phoneCall,
        sickDay,
        specialOccasion,
        travel,
        vacation,
      ];

  @override
  String toString() {
    return 'Keyword('
        'anniversary: $anniversary, '
        'appointment: $appointment, '
        'business: $business, '
        'education: $education, '
        'holiday: $holiday, '
        'meeting: $meeting, '
        'miscellaneous: $miscellaneous, '
        'nonWorkingHrs: $nonWorkingHrs, '
        'notInOffice: $notInOffice, '
        'personal: $personal, '
        'phoneCall: $phoneCall, '
        'sickDay: $sickDay, '
        'specialOccasion: $specialOccasion, '
        'travel: $travel, '
        'vacation: $vacation'
        ')';
  }
}

  Keyword _$KeywordFromJson(Map<String, dynamic> json) => Keyword(
    anniversary: json['Anniversary'] as bool?,
    appointment: json['Appointment'] as bool?,
    business: json['Business'] as bool?,
    education: json['Education'] as bool?,
    holiday: json['Holiday'] as bool?,
    meeting: json['Meeting'] as bool?,
    miscellaneous: json['Miscellaneous'] as bool?,
    nonWorkingHrs: json['Non-working hrs'] as bool?,
    notInOffice: json['Not in office'] as bool?,
    personal: json['Personal'] as bool?,
    phoneCall: json['Phone call'] as bool?,
    sickDay: json['Sick day'] as bool?,
    specialOccasion: json['Special occasion'] as bool?,
    travel: json['Travel'] as bool?,
    vacation: json['Vacation'] as bool?,

  );

  Map<String, dynamic> _$KeywordToJson(Keyword instance) {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('Anniversary', instance.anniversary);
    writeNotNull('Appointment', instance.appointment);
    writeNotNull('Business', instance.business);
    writeNotNull('Education', instance.education);
    writeNotNull('Holiday', instance.holiday);
    writeNotNull('Meeting', instance.meeting);
    writeNotNull('Miscellaneous', instance.miscellaneous);
    writeNotNull('Non-working hrs', instance.nonWorkingHrs);
    writeNotNull('Not in office', instance.notInOffice);
    writeNotNull('Personal', instance.personal);
    writeNotNull('Phone call', instance.phoneCall);
    writeNotNull('Sick day', instance.sickDay);
    writeNotNull('Special occasion', instance.specialOccasion);
    writeNotNull('Travel', instance.travel);
    writeNotNull('Vacation', instance.vacation);

    return val;
  }

